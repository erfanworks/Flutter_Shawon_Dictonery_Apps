import 'package:flutter/material.dart';

/// Theme-bound color tokens registered on [ThemeData] via [ThemeExtension].
/// Light / dark palettes stay in one place so text and surfaces stay consistent.
@immutable
class AppColorScheme extends ThemeExtension<AppColorScheme> {
  final Color bgPaper;
  final Color bgPaperRaised;
  final Color bgPaperSunken;
  final Color ink900;
  final Color ink700;
  final Color ink500;
  final Color ink300;
  final Color ink100;
  final Color marigold;
  final Color marigoldDim;
  final Color sage;
  final Color sageDim;
  final Color brick;
  final Color brickDim;

  const AppColorScheme({
    required this.bgPaper,
    required this.bgPaperRaised,
    required this.bgPaperSunken,
    required this.ink900,
    required this.ink700,
    required this.ink500,
    required this.ink300,
    required this.ink100,
    required this.marigold,
    required this.marigoldDim,
    required this.sage,
    required this.sageDim,
    required this.brick,
    required this.brickDim,
  });

  static const light = AppColorScheme(
    bgPaper: Color(0xFFF6F5F1),
    bgPaperRaised: Color(0xFFFCFBF8),
    bgPaperSunken: Color(0xFFECE9E2),
    ink900: Color(0xFF1C1E1A),
    ink700: Color(0xFF3A3D36),
    ink500: Color(0xFF6B6F66),
    ink300: Color(0xFFA6AA9F),
    ink100: Color(0xFFDCDCD2),
    marigold: Color(0xFF2F6E4F),
    marigoldDim: Color(0xFFDCEAE1),
    sage: Color(0xFFD98C3D),
    sageDim: Color(0xFFF4E3CC),
    brick: Color(0xFFBE5B4D),
    brickDim: Color(0xFFF3DCD4),
  );

  /// Dark palette: ink300 kept lighter than the old #565A4E so chevrons /
  /// secondary labels stay readable on dark paper.
  static const dark = AppColorScheme(
    bgPaper: Color(0xFF12140F),
    bgPaperRaised: Color(0xFF1A1D16),
    bgPaperSunken: Color(0xFF21251C),
    ink900: Color(0xFFEDEEE8),
    ink700: Color(0xFFC9CCC0),
    ink500: Color(0xFF9AA091),
    ink300: Color(0xFF8B9082),
    ink100: Color(0xFF2A2E22),
    marigold: Color(0xFF4F9C74),
    marigoldDim: Color(0x2E4F9C74),
    sage: Color(0xFFE3A35E),
    sageDim: Color(0x2EE3A35E),
    brick: Color(0xFFD97A6C),
    brickDim: Color(0x2ED97A6C),
  );

  @override
  AppColorScheme copyWith({
    Color? bgPaper,
    Color? bgPaperRaised,
    Color? bgPaperSunken,
    Color? ink900,
    Color? ink700,
    Color? ink500,
    Color? ink300,
    Color? ink100,
    Color? marigold,
    Color? marigoldDim,
    Color? sage,
    Color? sageDim,
    Color? brick,
    Color? brickDim,
  }) {
    return AppColorScheme(
      bgPaper: bgPaper ?? this.bgPaper,
      bgPaperRaised: bgPaperRaised ?? this.bgPaperRaised,
      bgPaperSunken: bgPaperSunken ?? this.bgPaperSunken,
      ink900: ink900 ?? this.ink900,
      ink700: ink700 ?? this.ink700,
      ink500: ink500 ?? this.ink500,
      ink300: ink300 ?? this.ink300,
      ink100: ink100 ?? this.ink100,
      marigold: marigold ?? this.marigold,
      marigoldDim: marigoldDim ?? this.marigoldDim,
      sage: sage ?? this.sage,
      sageDim: sageDim ?? this.sageDim,
      brick: brick ?? this.brick,
      brickDim: brickDim ?? this.brickDim,
    );
  }

  @override
  AppColorScheme lerp(ThemeExtension<AppColorScheme>? other, double t) {
    if (other is! AppColorScheme) return this;
    return AppColorScheme(
      bgPaper: Color.lerp(bgPaper, other.bgPaper, t)!,
      bgPaperRaised: Color.lerp(bgPaperRaised, other.bgPaperRaised, t)!,
      bgPaperSunken: Color.lerp(bgPaperSunken, other.bgPaperSunken, t)!,
      ink900: Color.lerp(ink900, other.ink900, t)!,
      ink700: Color.lerp(ink700, other.ink700, t)!,
      ink500: Color.lerp(ink500, other.ink500, t)!,
      ink300: Color.lerp(ink300, other.ink300, t)!,
      ink100: Color.lerp(ink100, other.ink100, t)!,
      marigold: Color.lerp(marigold, other.marigold, t)!,
      marigoldDim: Color.lerp(marigoldDim, other.marigoldDim, t)!,
      sage: Color.lerp(sage, other.sage, t)!,
      sageDim: Color.lerp(sageDim, other.sageDim, t)!,
      brick: Color.lerp(brick, other.brick, t)!,
      brickDim: Color.lerp(brickDim, other.brickDim, t)!,
    );
  }
}
