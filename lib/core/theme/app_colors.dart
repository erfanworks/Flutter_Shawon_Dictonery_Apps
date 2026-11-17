import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_color_scheme.dart';
import 'app_theme_scope.dart';
import 'theme_controller.dart';

/// App-wide color accessors.
///
/// [ThemeController.isDark] is the source of truth (not [Get.isDarkMode]), so
/// light / dark / system switches stay consistent.
class AppColors {
  AppColors._();

  static AppColorScheme get _scheme {
    if (Get.isRegistered<ThemeController>()) {
      return Get.find<ThemeController>().isDark ? AppColorScheme.dark : AppColorScheme.light;
    }
    final context = Get.context;
    if (context != null) {
      final scope = context.getElementForInheritedWidgetOfExactType<AppThemeScope>()?.widget;
      if (scope is AppThemeScope) return scope.colors;
      final ext = Theme.of(context).extension<AppColorScheme>();
      if (ext != null) return ext;
    }
    final platformDark =
        WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
    return platformDark ? AppColorScheme.dark : AppColorScheme.light;
  }

  /// Context-aware resolve — also registers an [AppThemeScope] dependency when present.
  static AppColorScheme of(BuildContext context) {
    final scope = AppThemeScope.maybeOf(context);
    if (scope != null) return scope.colors;
    if (Get.isRegistered<ThemeController>()) {
      return Get.find<ThemeController>().isDark ? AppColorScheme.dark : AppColorScheme.light;
    }
    return Theme.of(context).extension<AppColorScheme>() ?? _scheme;
  }

  // Surfaces
  static Color get bgPaper => _scheme.bgPaper;
  static Color get bgPaperRaised => _scheme.bgPaperRaised;
  static Color get bgPaperSunken => _scheme.bgPaperSunken;

  // Ink (text)
  static Color get ink900 => _scheme.ink900;
  static Color get ink700 => _scheme.ink700;
  static Color get ink500 => _scheme.ink500;
  static Color get ink300 => _scheme.ink300;
  static Color get ink100 => _scheme.ink100;

  // Accents
  static Color get marigold => _scheme.marigold;
  static Color get marigoldDim => _scheme.marigoldDim;
  static Color get sage => _scheme.sage;
  static Color get sageDim => _scheme.sageDim;
  static Color get brick => _scheme.brick;
  static Color get brickDim => _scheme.brickDim;

  // Fixed (theme independent) — used by AppSnackbar / filled CTA labels
  static const Color inkPaperFixed = Color(0xFFF6F5F1);
  static const Color ink900Fixed = Color(0xFF1C1E1A);
}
