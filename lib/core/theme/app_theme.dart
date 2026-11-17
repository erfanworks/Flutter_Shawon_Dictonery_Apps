import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_color_scheme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData _build({required Brightness brightness}) {
    final colors = brightness == Brightness.dark ? AppColorScheme.dark : AppColorScheme.light;
    final baseText = GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: colors.bgPaper,
      primaryColor: colors.marigold,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      fontFamily: GoogleFonts.inter().fontFamily,
      extensions: <ThemeExtension<dynamic>>[colors],
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: colors.marigold,
        onPrimary: AppColorScheme.light.bgPaper,
        secondary: colors.sage,
        onSecondary: AppColorScheme.light.bgPaper,
        error: colors.brick,
        onError: AppColorScheme.light.bgPaper,
        surface: colors.bgPaper,
        onSurface: colors.ink900,
      ),
      textTheme: baseText.apply(
        bodyColor: colors.ink900,
        displayColor: colors.ink900,
      ),
      primaryTextTheme: baseText.apply(
        bodyColor: colors.ink900,
        displayColor: colors.ink900,
      ),
      iconTheme: IconThemeData(color: colors.ink900),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.bgPaper,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        foregroundColor: colors.ink900,
        titleTextStyle: GoogleFonts.inter(
          color: colors.ink900,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(color: colors.ink900),
      ),
      dividerColor: colors.ink100,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.bgPaperRaised,
        surfaceTintColor: Colors.transparent,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: _SharedAxisTransitionBuilder(),
          TargetPlatform.iOS: _SharedAxisTransitionBuilder(),
        },
      ),
    );
  }

  static ThemeData get light => _build(brightness: Brightness.light);
  static ThemeData get dark => _build(brightness: Brightness.dark);
}

/// Shared-axis-style horizontal push, per motion guidelines.
class _SharedAxisTransitionBuilder extends PageTransitionsBuilder {
  const _SharedAxisTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic);
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0.12, 0), end: Offset.zero).animate(curved),
      child: FadeTransition(opacity: curved, child: child),
    );
  }
}
