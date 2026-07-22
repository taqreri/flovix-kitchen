import 'package:flovix_kitchen/utils/images/app_images.dart';
import 'package:flovix_kitchen/utils/routes/routes_name.dart';
import 'package:flovix_kitchen/utils/size_config.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //navigate();
  }

  void navigate() {
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.kitchenDisplayScreen,
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xFF0B1220),
      body: SizedBox(
        width: SizeConfig.width(context, 1),
        child: Image.asset(
          AppImages.splashScreen,

          fit: BoxFit.cover,
      //    alignment: Alignment.center,
        ),
      ),
    );
  }
}
