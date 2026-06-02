import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class AppTheme {
  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.green,
      brightness: brightness,
      primary: AppColors.green,
      secondary: AppColors.purple,
      surface: isDark ? const Color(0xFF141A18) : AppColors.bg,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      fontFamily: 'SF Pro Display',
      textTheme: Typography.material2021(platform: TargetPlatform.iOS).black.apply(
            fontFamily: 'SF Pro Display',
            bodyColor: isDark ? Colors.white : AppColors.ink,
            displayColor: isDark ? Colors.white : AppColors.ink,
          ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: isDark ? const Color(0xFF1B2420) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }
}
