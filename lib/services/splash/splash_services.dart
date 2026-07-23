import 'dart:async';

import 'package:flovix_kitchen/services/session_manager/session_controller.dart';
import 'package:flovix_kitchen/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashServices {
  Future<void> checkIfUserLoggedIn(BuildContext context) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    String? token =prefs.getString("user_token", );
    
    Future.delayed(const Duration(seconds: 2), () async {
      if((token?.isNotEmpty??false)&&token!=null){
       await SessionController().getUserFromPreference();
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.kitchenDisplayScreen,
              (route) => false,

        );
      }else{
        Navigator.pushNamedAndRemoveUntil(
          // ignore: use_build_context_synchronously
            context,
            RoutesName.loginScreen,
                (route) => false);
      }

    });
    // Timer(const Duration(seconds: 3), () => Navigator.pushNamedAndRemoveUntil(context, RoutesName.loginScreen, (route) => false));
  }
}
