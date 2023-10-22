import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/model/index.dart';
import 'package:weatherapp/services/index.dart';
import 'package:weatherapp/widgets/index.dart';

class CurrentPage extends StatefulWidget {
  final LocationModel location;
  const CurrentPage({required this.location, super.key});

  @override
  State<CurrentPage> createState() => _CurrentPageState();
}

class _CurrentPageState extends State<CurrentPage> {
  ValueNotifier<(bool, WeatherCurrentModel?)> valueNotifier =
      ValueNotifier((true, null));
  ValueNotifier<bool> isCached = ValueNotifier(false);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadWeatherCurrent();
      isCached.value = await checkItemInCache();
    });
    super.initState();
  }

  void loadWeatherCurrent() async {
    final weatherCurrent =
        await ApiService.i.weather.getCurrentWeather(widget.location.name!);
    valueNotifier.value = (false, weatherCurrent);
  }

  Future<bool> checkItemInCache() async {
    final List<LocationModel?> values =
        await HiveService.getList<LocationModel?>('locations', 'items');

    LocationModel? location = values.firstWhere(
        (element) => element?.id == widget.location.id,
        orElse: () => null);

    return location != null;
  }

  Future<void> addToCache() async {
    final values =
        await HiveService.getList<LocationModel?>('locations', 'items');

    LocationModel? value = values.firstWhere(
      (element) => element?.id == widget.location.id,
      orElse: () => null,
    );

    if (value != null) {
      return;
    }
    values.add(widget.location);
    isCached.value = true;
    await HiveService.putList("locations", 'items', values);
    return;
  }

  Widget get renderIcon {
    return ValueListenableBuilder(
      valueListenable: isCached,
      builder: (context, value, child) {
        return IconButton(
          onPressed: () {
            if (!value) {
              addToCache();
              return;
            }
          },
          icon: Icon(
            value ? Icons.check : Icons.add,
            size: 36.0,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [renderIcon],
      ),
      body: ValueListenableBuilder(
        valueListenable: valueNotifier,
        builder: (context, value, child) {
          if (value.$1) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }

          if (value.$2?.error != null) {
            return Center(
              child: Text(value.$2!.error!.msg),
            );
          }
          final current = value.$2!.currentModel;
          final location = value.$2!.locationModel;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  location?.name ?? "",
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox.square(
                      dimension: 64,
                      child: Image.network(current!.condition!.pathIcon),
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      "${current.tempC?.round()}" "\u2103",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Feels like: ${current.feelslikeC?.round()}\u2103",
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    current.condition?.text ?? "",
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      WeatherDetailInfo(
                        title: "pressue",
                        value: "${current.pressureMb?.ceil()} hpa",
                        icon: Icons.thermostat,
                      ),
                      WeatherDetailInfo(
                        icon: Icons.wind_power,
                        title: "wind speed",
                        value: "${current.windMph?.ceil()} m/s",
                      ),
                      WeatherDetailInfo(
                        icon: Icons.water_drop_outlined,
                        title: "humidity",
                        value: "${current.humidity?.ceil()} %",
                      ),
                      WeatherDetailInfo(
                        icon: Icons.cloud_outlined,
                        title: "cloud",
                        value: "${current.cloud?.ceil()} %",
                      ),
                      WeatherDetailInfo(
                        icon: Icons.navigation_outlined,
                        title: "wind direction",
                        value: "${current.windDir} (${current.windDegree})",
                      ),
                      WeatherDetailInfo(
                        icon: Icons.calendar_today,
                        title: "last update",
                        value: current.lastUpdated ?? "",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    valueNotifier.dispose();
    isCached.dispose();
    super.dispose();
  }
}
