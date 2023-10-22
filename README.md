# Weatherapp
[HOMEBASE] Take-home Assignment 

## Environment
``` Flutter version 3.10.6 (stable)```
``` Dart version 3.0.6```

## Environment File Configuration

In `key.json`, store your API keys and other sensitive information.

## Installation
The first you can run command line build_runner for Hive

``` flutter pub run build_runner build --delete-conflicting-outputs ```

with FVM:

``` fvm flutter pub run build_runner build --delete-conflicting-outputs ```

You can run project with command line:

``` flutter run -d <deviceID> --dart-define-from-file=key.json ```

with FVM:

```fvm flutter run -d <deviceID> --dart-define-from-file=key.json ```

### API Integration

- [WeatherAPI](https://www.weatherapi.com/): A weather data API for obtaining weather-related information.
