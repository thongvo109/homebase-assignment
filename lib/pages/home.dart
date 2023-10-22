import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/collection/location_collection.dart';
import 'package:weatherapp/services/api_service.dart';
import 'package:weatherapp/utils/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 500);
  final FocusNode _searchNode = FocusNode();
  final ValueNotifier<(bool, LocationCollection)> _valueNotifier =
      ValueNotifier((
    false,
    LocationCollection(),
  ));

  void searchLocation(String query) async {
    _valueNotifier.value = (true, LocationCollection());
    final value = await ApiService.i.weather.getLocation(query);
    _valueNotifier.value = (false, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: SizedBox(
        height: MediaQuery.sizeOf(context).height / 9,
        child: Center(
          child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/history');
              },
              icon: const Icon(Icons.history)),
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () {
          _searchNode.requestFocus();
        },
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Padding(
          padding: EdgeInsets.only(
            top: AppBar().preferredSize.height,
            left: 16,
            right: 16,
            bottom: 16,
          ),
          child: Column(
            children: [
              SearchBar(
                focusNode: _searchNode,
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shadowColor: MaterialStateProperty.all(Colors.white),
                surfaceTintColor: MaterialStateProperty.all(Colors.grey),
                hintText: 'Typing Name City or ZipCode',
                controller: _controller,
                trailing: <Widget>[
                  IconButton(
                    onPressed: () {
                      _controller.clear();
                    },
                    icon: const Icon(Icons.clear),
                  )
                ],
                onChanged: (value) {
                  _debouncer.run(() {
                    searchLocation(value);
                  });
                },
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: _valueNotifier,
                  builder: (context, value, child) {
                    if (value.$1) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }

                    if (value.$2.error != null) {
                      return Center(
                        child: Text(value.$2.error?.msg ??
                            "Something went wrong. Try again"),
                      );
                    }

                    if (value.$2.items.isEmpty && !value.$1) {
                      if (_controller.text.trim().isEmpty) {
                        return const SizedBox();
                      }
                      return Center(
                        child:
                            Text('No results found for "${_controller.text}"'),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      itemCount: value.$2.items.length,
                      itemBuilder: (context, index) {
                        var item = value.$2.items[index];
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
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    _controller.dispose();
    _searchNode.dispose();
    super.dispose();
  }
}
