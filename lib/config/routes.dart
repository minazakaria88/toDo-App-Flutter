import 'package:flutter/material.dart';
import 'package:todo/feature/home/presentation/screens/home.dart';

class Routes {
  static const initRoute = '/';
}

class AppRoute {
  static Route  onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initRoute:
        return MaterialPageRoute(
          builder: (context) =>  Home(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(),
        );
    }
  }
}
