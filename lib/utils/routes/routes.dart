import 'package:flovix_kitchen/screens/kitchen/kitchen_display_screen.dart';
import 'package:flovix_kitchen/screens/login/login_screen.dart';
import 'package:flovix_kitchen/screens/splash/splash_screen.dart';
import 'package:flovix_kitchen/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RoutesName.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case RoutesName.kitchenDisplayScreen:
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (_) => const KitchenDisplayScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
