import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/bindings/initial_binding.dart';
import 'core/theme/app_color_scheme.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_theme_scope.dart';
import 'core/theme/text_scale_controller.dart';
import 'core/theme/theme_controller.dart';
import 'constant/const_string.dart';
import 'routes/app_routes.dart';
import 'routes/app_routes_file.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = true;
  // Register theme early so AppColors is ready on first frame.
  Get.put(ThemeController(), permanent: true);
  Get.put(TextScaleController(), permanent: true);
  runApp(const LexoraApp());
}

class LexoraApp extends StatelessWidget {
  const LexoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: ConstString.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: Get.find<ThemeController>().materialThemeMode,
          initialBinding: InitialBinding(),
          initialRoute: AppRoutes.splashScreen,
          getPages: appRouteFile,
          builder: (context, widget) {
            final themeController = Get.find<ThemeController>();
            final textScaleController = Get.find<TextScaleController>();
            return Obx(() {
              final revision = themeController.revision.value;
              final isDark = themeController.isDark;
              final colors = isDark ? AppColorScheme.dark : AppColorScheme.light;
              final themeData = isDark ? AppTheme.dark : AppTheme.light;
              final mq = MediaQuery.of(context);
              return MediaQuery(
                data: mq.copyWith(
                  textScaler: TextScaler.linear(textScaleController.option.value.scale),
                ),
                child: Theme(
                  data: themeData,
                  child: AppThemeScope(
                    revision: revision,
                    colors: colors,
                    isDark: isDark,
                    // Depends on AppThemeScope so the navigator + routes rebuild
                    // and re-read AppColors when theme changes.
                    child: _ThemeAwareShell(child: widget ?? const SizedBox.shrink()),
                  ),
                ),
              );
            });
          },
        );
      },
    );
  }
}

class _ThemeAwareShell extends StatelessWidget {
  final Widget child;

  const _ThemeAwareShell({required this.child});

  @override
  Widget build(BuildContext context) {
    AppThemeScope.of(context);
    return child;
  }
}
