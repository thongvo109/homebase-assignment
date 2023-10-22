import 'package:flutter/material.dart';
import 'package:weatherapp/model/location_model.dart';
import 'package:weatherapp/pages/index.dart';

class AppRouters {
  static Route onGenerateRoute(RouteSettings settings) {
    if (settings.name == null) {
      return MaterialPageRoute(builder: (_) => const HomePage());
    }
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) {
            return const HomePage();
          },
        );
      case "/history":
        return MaterialPageRoute(builder: (context) => const HistoryPage());
      case "/current":
        return MaterialPageRoute(
          builder: (context) => CurrentPage(
            location: settings.arguments as LocationModel,
          ),
        );
      default:
    }
    return MaterialPageRoute(builder: (_) => const HomePage());
  }
}
