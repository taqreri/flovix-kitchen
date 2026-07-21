import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flovix_kitchen/screens/chucker_debug_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/platform/platform_info.dart' show PlatformInfo;


/// Small on-screen control to open Chucker on Windows desktop (debug builds).
class WindowsApiDebugOverlay extends StatelessWidget {
  const WindowsApiDebugOverlay({super.key, required this.child});

  final Widget child;

  static bool get isVisible =>
      PlatformInfo.isWindows &&
      kDebugMode &&
      ChuckerDebugService.isAllowedFlavor;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return child;

    return Stack(
      alignment: Alignment.topLeft,
      textDirection: TextDirection.ltr,
      children: [
        child,
        Positioned(
          right: 12,
          bottom: 12,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            color: Colors.black87,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                if (ChuckerDebugService.shouldUseChucker) {
                  ChuckerFlutter.showChuckerScreen();
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  'API',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
