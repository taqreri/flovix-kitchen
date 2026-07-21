import 'package:flovix_kitchen/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';


class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
/*      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashPage());

      case RoutesName.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginPage());*/



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
