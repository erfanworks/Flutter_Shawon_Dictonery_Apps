import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeOption { light, dark, system }

class ThemeController extends GetxController with WidgetsBindingObserver {
  static const _prefsKey = 'app_theme_option';

  final Rx<AppThemeOption> themeOption = AppThemeOption.system.obs;

  /// Bumped on every theme / platform-brightness change so UI that reads
  /// [AppColors] can subscribe via [Obx] / [ThemeRebuild] and repaint.
  final RxInt revision = 0.obs;

  ThemeMode get materialThemeMode {
    switch (themeOption.value) {
      case AppThemeOption.light:
        return ThemeMode.light;
      case AppThemeOption.dark:
        return ThemeMode.dark;
      case AppThemeOption.system:
        return ThemeMode.system;
    }
  }

  /// Source of truth for light vs dark — does not rely on [Get.isDarkMode].
  bool get isDark {
    switch (themeOption.value) {
      case AppThemeOption.light:
        return false;
      case AppThemeOption.dark:
        return true;
      case AppThemeOption.system:
        return WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
    }
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _restore();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangePlatformBrightness() {
    if (themeOption.value == AppThemeOption.system) {
      _apply(bumpRevision: true);
    }
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_prefsKey);
    if (saved != null) {
      themeOption.value = AppThemeOption.values.firstWhere(
        (e) => e.name == saved,
        orElse: () => AppThemeOption.system,
      );
    }
    _apply(bumpRevision: true);
  }

  Future<void> setTheme(AppThemeOption option) async {
    themeOption.value = option;
    _apply(bumpRevision: true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, option.name);
  }

  void _apply({bool bumpRevision = false}) {
    Get.changeThemeMode(materialThemeMode);
    if (bumpRevision) {
      revision.value++;
    }
  }
}
