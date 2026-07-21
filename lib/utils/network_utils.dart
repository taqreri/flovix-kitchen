import 'package:flovix_kitchen/services/session_manager/session_controller.dart';
import 'package:flutter/cupertino.dart';

class NetworkUtils {
  static Future<Map<String, String>> getHeaderWithToken(
      {bool isToken = true}) async {
    await SessionController().getUserFromPreference();
    final token = SessionController.user.token ?? '';

    debugPrint('userAuthToken Init: $token');

    return token.isNotEmpty && isToken
        ? {
            "Content-Type": "application/json",
            "Accept": "application/json",
      "Content-Disposition":"inline",
            "Authorization": "Bearer $token", //'Accept': 'application/json',
          }
        : {
            "Accept": "application/json",
            "Content-Type": "application/json", //'Accept': 'application/json',
          };
  }
}
