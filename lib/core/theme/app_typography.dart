import 'package:flutter/material.dart';

/// Named text styles, keyed by role rather than by size.
///
/// Sizes carry no colour: colour comes from [AppColors] at the call site, so
/// the same style works on light, dark and premium surfaces.
@immutable
class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({
    required this.displayLg,
    required this.displayMd,
    required this.titleLg,
    required this.titleMd,
    required this.titleSm,
    required this.bodyLg,
    required this.bodyMd,
    required this.bodySm,
    required this.label,
    required this.caption,
    required this.button,
  });

  /// Onboarding headline.
  final TextStyle displayLg;

  /// Paywall headline.
  final TextStyle displayMd;

  /// Home greeting, section headings.
  final TextStyle titleLg;

  /// Card titles.
  final TextStyle titleMd;

  /// Plan tile titles.
  final TextStyle titleSm;

  final TextStyle bodyLg;
  final TextStyle bodyMd;
  final TextStyle bodySm;

  /// Field labels and chips.
  final TextStyle label;

  /// Legal copy, image credits.
  final TextStyle caption;

  final TextStyle button;

  static const AppTypography regular = AppTypography(
    displayLg: TextStyle(
      fontSize: 28,
      height: 1.2,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
    ),
    displayMd: TextStyle(
      fontSize: 27,
      height: 1.2,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.5,
    ),
    titleLg: TextStyle(fontSize: 24, height: 1.25, fontWeight: FontWeight.w600),
    titleMd: TextStyle(fontSize: 16, height: 1.3, fontWeight: FontWeight.w600),
    titleSm: TextStyle(fontSize: 14, height: 1.3, fontWeight: FontWeight.w600),
    bodyLg: TextStyle(fontSize: 16, height: 1.4, fontWeight: FontWeight.w400),
    bodyMd: TextStyle(fontSize: 14, height: 1.4, fontWeight: FontWeight.w400),
    bodySm: TextStyle(fontSize: 12, height: 1.35, fontWeight: FontWeight.w400),
    label: TextStyle(fontSize: 13, height: 1.3, fontWeight: FontWeight.w500),
    caption: TextStyle(fontSize: 10, height: 1.3, fontWeight: FontWeight.w400),
    button: TextStyle(
      fontSize: 15,
      height: 1.2,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    ),
  );

  @override
  AppTypography copyWith({
    TextStyle? displayLg,
    TextStyle? displayMd,
    TextStyle? titleLg,
    TextStyle? titleMd,
    TextStyle? titleSm,
    TextStyle? bodyLg,
    TextStyle? bodyMd,
    TextStyle? bodySm,
    TextStyle? label,
    TextStyle? caption,
    TextStyle? button,
  }) {
    return AppTypography(
      displayLg: displayLg ?? this.displayLg,
      displayMd: displayMd ?? this.displayMd,
      titleLg: titleLg ?? this.titleLg,
      titleMd: titleMd ?? this.titleMd,
      titleSm: titleSm ?? this.titleSm,
      bodyLg: bodyLg ?? this.bodyLg,
      bodyMd: bodyMd ?? this.bodyMd,
      bodySm: bodySm ?? this.bodySm,
      label: label ?? this.label,
      caption: caption ?? this.caption,
      button: button ?? this.button,
    );
  }

  @override
  AppTypography lerp(covariant AppTypography? other, double t) {
    if (other == null) return this;
    return AppTypography(
      displayLg: TextStyle.lerp(displayLg, other.displayLg, t)!,
      displayMd: TextStyle.lerp(displayMd, other.displayMd, t)!,
      titleLg: TextStyle.lerp(titleLg, other.titleLg, t)!,
      titleMd: TextStyle.lerp(titleMd, other.titleMd, t)!,
      titleSm: TextStyle.lerp(titleSm, other.titleSm, t)!,
      bodyLg: TextStyle.lerp(bodyLg, other.bodyLg, t)!,
      bodyMd: TextStyle.lerp(bodyMd, other.bodyMd, t)!,
      bodySm: TextStyle.lerp(bodySm, other.bodySm, t)!,
      label: TextStyle.lerp(label, other.label, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
      button: TextStyle.lerp(button, other.button, t)!,
    );
  }
}
