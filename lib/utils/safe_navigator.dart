import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Defers [Navigator] operations until after the current frame / route transition
/// so `!_debugLocked` assertions are not triggered.
class SafeNavigator {
  SafeNavigator._();

  /// Waits until the navigator is unlikely to be mid-transition.
  static Future<void> afterUnlocked() async {
    await SchedulerBinding.instance.endOfFrame;
    await Future<void>.delayed(Duration.zero);
    await SchedulerBinding.instance.endOfFrame;
  }

  /// Runs [action] after [afterUnlocked].
  static void run(void Function() action) {
    afterUnlocked().then((_) => action());
  }

  static Future<T?> showDialogSafe<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    bool useRootNavigator = true,
    Color? barrierColor,
    String? barrierLabel,
  }) async {
    await afterUnlocked();
    if (!context.mounted) return null;
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      useRootNavigator: useRootNavigator,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      builder: builder,
    );
  }

  static void popSafe(BuildContext context, [Object? result]) {
    run(() {
      if (!context.mounted) return;
      Navigator.of(context).pop(result);
    });
  }

  static void popRootSafe(BuildContext context, [Object? result]) {
    run(() {
      if (!context.mounted) return;
      Navigator.of(context, rootNavigator: true).pop(result);
    });
  }

  static Future<T?> pushSafe<T extends Object?>(
    BuildContext context,
    Route<T> route,
  ) async {
    await afterUnlocked();
    if (!context.mounted) return null;
    return Navigator.of(context).push<T>(route);
  }

  static Future<T?> pushNamedSafe<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) async {
    await afterUnlocked();
    if (!context.mounted) return null;
    return Navigator.of(context).pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<void> pushNamedAndRemoveUntilSafe(
    BuildContext context,
    String routeName,
    RoutePredicate predicate, {
    Object? arguments,
  }) async {
    await afterUnlocked();
    if (!context.mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  static Future<T?> pushReplacementSafe<T extends Object?, TO extends Object?>(
    BuildContext context,
    Route<T> newRoute, {
    TO? result,
  }) async {
    await afterUnlocked();
    if (!context.mounted) return null;
    return Navigator.of(context).pushReplacement<T, TO>(newRoute, result: result);
  }
}
