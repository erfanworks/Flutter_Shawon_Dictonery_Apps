import 'package:flutter/material.dart';
import 'app_color_scheme.dart';

/// Inherited scope so any [BuildContext] under the app can depend on theme
/// changes and rebuild when light / dark / system switches.
class AppThemeScope extends InheritedWidget {
  final int revision;
  final AppColorScheme colors;
  final bool isDark;

  const AppThemeScope({
    super.key,
    required this.revision,
    required this.colors,
    required this.isDark,
    required super.child,
  });

  static AppThemeScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppThemeScope>();
    assert(scope != null, 'AppThemeScope not found in context');
    return scope!;
  }

  static AppThemeScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppThemeScope>();
  }

  @override
  bool updateShouldNotify(AppThemeScope oldWidget) {
    return revision != oldWidget.revision || isDark != oldWidget.isDark;
  }
}
