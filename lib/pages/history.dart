import 'package:flutter/material.dart';
import 'package:weatherapp/model/location_model.dart';
import 'package:weatherapp/services/hive_service.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  ValueNotifier<List<LocationModel>> valueNotifier = ValueNotifier([]);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      valueNotifier.value =
          await HiveService.getList<LocationModel>('locations', 'items');
    });
    super.initState();
  }

  Future<void> deleteItem(int id) async {
    List<LocationModel> currentList = valueNotifier.value;

    currentList.removeWhere((element) => element.id == id);

    await HiveService.putList('locations', 'items', currentList);

    valueNotifier.value =
        await HiveService.getList<LocationModel>('locations', 'items');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Saved Location'),
      ),
      body: ValueListenableBuilder(
        valueListenable: valueNotifier,
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              var item = value[index];
              return Card(
                color: Colors.white,
                surfaceTintColor: Colors.white,
                elevation: 4,
                child: Column(
                  children: [
                    ListTile(
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/current',
                          arguments: item,
                        );
                      },
                      title: Text(item.name ?? ""),
                      subtitle: Text(item.country ?? ""),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                        ),
                        onPressed: () {
                          deleteItem(item.id ?? 0);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
