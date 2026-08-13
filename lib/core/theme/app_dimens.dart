import 'package:flutter/material.dart';

/// The spacing, radius and sizing scale.
///
/// Every gap, padding and corner in the app comes from here. A literal
/// `EdgeInsets.all(16)` in a widget is a bug — use `context.appDimens`.
@immutable
class AppDimens extends ThemeExtension<AppDimens> {
  const AppDimens({
    required this.spaceXxs,
    required this.spaceXs,
    required this.spaceSm,
    required this.spaceMd,
    required this.spaceLg,
    required this.spaceXl,
    required this.spaceXxl,
    required this.radiusSm,
    required this.radiusMd,
    required this.radiusLg,
    required this.radiusXl,
    required this.strokeThin,
    required this.strokeThick,
    required this.controlHeight,
    required this.iconSm,
    required this.iconMd,
    required this.pageGutter,
  });

  final double spaceXxs;
  final double spaceXs;
  final double spaceSm;
  final double spaceMd;
  final double spaceLg;
  final double spaceXl;
  final double spaceXxl;

  final double radiusSm;
  final double radiusMd;
  final double radiusLg;
  final double radiusXl;

  final double strokeThin;
  final double strokeThick;

  /// Minimum height of a tappable control — also the accessibility floor.
  final double controlHeight;

  final double iconSm;
  final double iconMd;

  /// Horizontal page padding.
  final double pageGutter;

  static const AppDimens regular = AppDimens(
    spaceXxs: 2,
    spaceXs: 4,
    spaceSm: 8,
    spaceMd: 12,
    spaceLg: 16,
    spaceXl: 24,
    spaceXxl: 32,
    radiusSm: 6,
    radiusMd: 12,
    radiusLg: 16,
    radiusXl: 24,
    strokeThin: 1,
    strokeThick: 2,
    controlHeight: 56,
    iconSm: 16,
    iconMd: 24,
    pageGutter: 24,
  );

  /// Tighter scale for short viewports (small phones, landscape).
  static const AppDimens compact = AppDimens(
    spaceXxs: 2,
    spaceXs: 3,
    spaceSm: 6,
    spaceMd: 10,
    spaceLg: 12,
    spaceXl: 16,
    spaceXxl: 20,
    radiusSm: 6,
    radiusMd: 12,
    radiusLg: 14,
    radiusXl: 20,
    strokeThin: 1,
    strokeThick: 2,
    controlHeight: 48,
    iconSm: 16,
    iconMd: 22,
    pageGutter: 20,
  );

  @override
  AppDimens copyWith({
    double? spaceXxs,
    double? spaceXs,
    double? spaceSm,
    double? spaceMd,
    double? spaceLg,
    double? spaceXl,
    double? spaceXxl,
    double? radiusSm,
    double? radiusMd,
    double? radiusLg,
    double? radiusXl,
    double? strokeThin,
    double? strokeThick,
    double? controlHeight,
    double? iconSm,
    double? iconMd,
    double? pageGutter,
  }) {
    return AppDimens(
      spaceXxs: spaceXxs ?? this.spaceXxs,
      spaceXs: spaceXs ?? this.spaceXs,
      spaceSm: spaceSm ?? this.spaceSm,
      spaceMd: spaceMd ?? this.spaceMd,
      spaceLg: spaceLg ?? this.spaceLg,
      spaceXl: spaceXl ?? this.spaceXl,
      spaceXxl: spaceXxl ?? this.spaceXxl,
      radiusSm: radiusSm ?? this.radiusSm,
      radiusMd: radiusMd ?? this.radiusMd,
      radiusLg: radiusLg ?? this.radiusLg,
      radiusXl: radiusXl ?? this.radiusXl,
      strokeThin: strokeThin ?? this.strokeThin,
      strokeThick: strokeThick ?? this.strokeThick,
      controlHeight: controlHeight ?? this.controlHeight,
      iconSm: iconSm ?? this.iconSm,
      iconMd: iconMd ?? this.iconMd,
      pageGutter: pageGutter ?? this.pageGutter,
    );
  }

  @override
  AppDimens lerp(covariant AppDimens? other, double t) {
    if (other == null) return this;
    return AppDimens(
      spaceXxs: lerpDouble(spaceXxs, other.spaceXxs, t),
      spaceXs: lerpDouble(spaceXs, other.spaceXs, t),
      spaceSm: lerpDouble(spaceSm, other.spaceSm, t),
      spaceMd: lerpDouble(spaceMd, other.spaceMd, t),
      spaceLg: lerpDouble(spaceLg, other.spaceLg, t),
      spaceXl: lerpDouble(spaceXl, other.spaceXl, t),
      spaceXxl: lerpDouble(spaceXxl, other.spaceXxl, t),
      radiusSm: lerpDouble(radiusSm, other.radiusSm, t),
      radiusMd: lerpDouble(radiusMd, other.radiusMd, t),
      radiusLg: lerpDouble(radiusLg, other.radiusLg, t),
      radiusXl: lerpDouble(radiusXl, other.radiusXl, t),
      strokeThin: lerpDouble(strokeThin, other.strokeThin, t),
      strokeThick: lerpDouble(strokeThick, other.strokeThick, t),
      controlHeight: lerpDouble(controlHeight, other.controlHeight, t),
      iconSm: lerpDouble(iconSm, other.iconSm, t),
      iconMd: lerpDouble(iconMd, other.iconMd, t),
      pageGutter: lerpDouble(pageGutter, other.pageGutter, t),
    );
  }

  static double lerpDouble(double a, double b, double t) => a + (b - a) * t;
}
