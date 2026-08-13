import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/theme/app_colors.dart';
import 'package:hubx_flutter_case/core/theme/app_dimens.dart';
import 'package:hubx_flutter_case/core/theme/app_typography.dart';

/// Builds the two [ThemeData]s the app ships with.
///
/// Material's own [ColorScheme] is derived from [AppColors] so that stock
/// widgets (dialogs, text selection, ripples) stay on-brand, while our own
/// widgets read the extensions directly.
abstract final class AppTheme {
  static ThemeData light() => _build(Brightness.light, AppColors.light);

  static ThemeData dark() => _build(Brightness.dark, AppColors.dark);

  static ThemeData _build(Brightness brightness, AppColors colors) {
    final ColorScheme scheme = ColorScheme(
      brightness: brightness,
      primary: colors.brand,
      onPrimary: Colors.white,
      secondary: colors.premiumAccent,
      onSecondary: colors.premiumCanvas,
      error: colors.danger,
      onError: Colors.white,
      surface: colors.surface,
      onSurface: colors.onCanvas,
    );

    const AppTypography typography = AppTypography.regular;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: colors.canvas,
      splashFactory: InkSparkle.splashFactory,
      extensions: <ThemeExtension<dynamic>>[
        colors,
        AppDimens.regular,
        typography,
      ],
      textTheme: TextTheme(
        displayLarge: typography.displayLg,
        displayMedium: typography.displayMd,
        titleLarge: typography.titleLg,
        titleMedium: typography.titleMd,
        titleSmall: typography.titleSm,
        bodyLarge: typography.bodyLg,
        bodyMedium: typography.bodyMd,
        bodySmall: typography.bodySm,
        labelLarge: typography.button,
        labelMedium: typography.label,
        labelSmall: typography.caption,
      ).apply(bodyColor: colors.onCanvas, displayColor: colors.onCanvas),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.canvas,
        foregroundColor: colors.onCanvas,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: typography.titleMd.copyWith(color: colors.onCanvas),
      ),
      dividerTheme: DividerThemeData(
        color: colors.outline,
        space: 0,
        thickness: AppDimens.regular.strokeThin,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: colors.brand),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.onCanvas,
        contentTextStyle: typography.bodyMd.copyWith(color: colors.canvas),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
