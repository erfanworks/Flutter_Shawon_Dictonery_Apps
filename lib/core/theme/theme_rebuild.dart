import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_theme_scope.dart';
import 'theme_controller.dart';

/// Rebuilds via [builder] whenever light / dark / system theme changes.
/// Always listens to [ThemeController.revision] so IndexedStack tabs refresh.
class ThemeRebuild extends StatelessWidget {
  final WidgetBuilder builder;

  const ThemeRebuild({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    // Register InheritedWidget dependency when available.
    AppThemeScope.maybeOf(context);

    if (!Get.isRegistered<ThemeController>()) {
      return builder(context);
    }

    return Obx(() {
      Get.find<ThemeController>().revision.value;
      return builder(context);
    });
  }
}
