import 'package:flutter/material.dart';

/// Semantic colour roles for the whole app.
///
/// Widgets read these through `context.appColors` and never construct a
/// [Color] themselves, so a palette change is a one-file change.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.brand,
    required this.brandMuted,
    required this.canvas,
    required this.surface,
    required this.surfaceMuted,
    required this.onCanvas,
    required this.onCanvasMuted,
    required this.onCanvasSubtle,
    required this.outline,
    required this.outlineStrong,
    required this.navInactive,
    required this.bannerSurface,
    required this.premiumCanvas,
    required this.premiumSurface,
    required this.premiumAccent,
    required this.premiumAccentMuted,
    required this.premiumOutline,
    required this.onPremium,
    required this.onPremiumMuted,
    required this.danger,
    required this.scrim,
  });

  /// Primary green used for CTAs, selection and progress.
  final Color brand;

  /// Low-emphasis wash of [brand], for tinted backgrounds.
  final Color brandMuted;

  /// Page background.
  final Color canvas;

  /// Cards and sheets sitting on [canvas].
  final Color surface;

  /// Secondary fills: chips, skeletons, image placeholders.
  final Color surfaceMuted;

  /// Primary text and icons on [canvas]/[surface].
  final Color onCanvas;

  /// Secondary text — captions, subtitles.
  final Color onCanvasMuted;

  /// Tertiary text — placeholders, disabled labels.
  final Color onCanvasSubtle;

  /// Hairline dividers and card borders.
  final Color outline;

  /// Emphasised borders: selected states, focused fields.
  final Color outlineStrong;

  /// The unselected destinations in the bottom bar. Deliberately a neutral
  /// grey rather than a tint of [onCanvas]: in the design the bar's inactive
  /// items carry no green at all, which is what makes Home read as current.
  final Color navInactive;

  /// The "get premium" strip. Flat in the design, not a gradient.
  final Color bannerSurface;

  /// Paywall/premium background, dark in both brightnesses by design.
  final Color premiumCanvas;

  /// Cards on [premiumCanvas] — plan tiles, feature tiles.
  final Color premiumSurface;

  /// Gold accent used for premium copy and the "get premium" banner.
  final Color premiumAccent;

  /// The duller gold the strip uses for its second line and its chevron —
  /// darker than [premiumAccent], not lighter.
  final Color premiumAccentMuted;

  /// Border for unselected plan tiles.
  final Color premiumOutline;

  /// Text on premium surfaces.
  final Color onPremium;

  /// Secondary text on premium surfaces.
  final Color onPremiumMuted;

  /// Error states, in text and on the retry surface.
  final Color danger;

  /// Overlay behind images so foreground text stays legible.
  final Color scrim;

  static const AppColors light = AppColors(
    brand: Color(0xFF28AF6E),
    brandMuted: Color(0xFFE9F7F0),
    canvas: Color(0xFFF7F7F7),
    surface: Color(0xFFFFFFFF),
    surfaceMuted: Color(0xFFF4F6F5),
    onCanvas: Color(0xFF13231B),
    onCanvasMuted: Color(0xFF597165),
    onCanvasSubtle: Color(0xFF9DA6A0),
    outline: Color(0xFFEDEFEE),
    outlineStrong: Color(0xFFD3DAD6),
    navInactive: Color(0xFFBDBDBD),
    bannerSurface: Color(0xFF24201A),
    premiumCanvas: Color(0xFF101E17),
    premiumSurface: Color(0xFF1B2C22),
    premiumAccent: Color(0xFFE5C990),
    premiumAccentMuted: Color(0xFFD0B070),
    premiumOutline: Color(0xFF3C4E44),
    onPremium: Color(0xFFFFFFFF),
    onPremiumMuted: Color(0xFFB3BDB7),
    danger: Color(0xFFD1453B),
    scrim: Color(0x66000000),
  );

  static const AppColors dark = AppColors(
    brand: Color(0xFF3FD08A),
    brandMuted: Color(0xFF163024),
    canvas: Color(0xFF0B1610),
    surface: Color(0xFF14241B),
    surfaceMuted: Color(0xFF1C3126),
    onCanvas: Color(0xFFF2F6F3),
    onCanvasMuted: Color(0xFFAFBDB5),
    onCanvasSubtle: Color(0xFF7C8B83),
    outline: Color(0xFF223328),
    outlineStrong: Color(0xFF354C3D),
    navInactive: Color(0xFF7C8B83),
    bannerSurface: Color(0xFF24201A),
    premiumCanvas: Color(0xFF0B1610),
    premiumSurface: Color(0xFF16281E),
    premiumAccent: Color(0xFFE5C990),
    premiumAccentMuted: Color(0xFFD0B070),
    premiumOutline: Color(0xFF3C4E44),
    onPremium: Color(0xFFFFFFFF),
    onPremiumMuted: Color(0xFFB3BDB7),
    danger: Color(0xFFF07167),
    scrim: Color(0x80000000),
  );

  @override
  AppColors copyWith({
    Color? brand,
    Color? brandMuted,
    Color? canvas,
    Color? surface,
    Color? surfaceMuted,
    Color? onCanvas,
    Color? onCanvasMuted,
    Color? onCanvasSubtle,
    Color? outline,
    Color? outlineStrong,
    Color? navInactive,
    Color? bannerSurface,
    Color? premiumCanvas,
    Color? premiumSurface,
    Color? premiumAccent,
    Color? premiumAccentMuted,
    Color? premiumOutline,
    Color? onPremium,
    Color? onPremiumMuted,
    Color? danger,
    Color? scrim,
  }) {
    return AppColors(
      brand: brand ?? this.brand,
      brandMuted: brandMuted ?? this.brandMuted,
      canvas: canvas ?? this.canvas,
      surface: surface ?? this.surface,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      onCanvas: onCanvas ?? this.onCanvas,
      onCanvasMuted: onCanvasMuted ?? this.onCanvasMuted,
      onCanvasSubtle: onCanvasSubtle ?? this.onCanvasSubtle,
      outline: outline ?? this.outline,
      outlineStrong: outlineStrong ?? this.outlineStrong,
      navInactive: navInactive ?? this.navInactive,
      bannerSurface: bannerSurface ?? this.bannerSurface,
      premiumCanvas: premiumCanvas ?? this.premiumCanvas,
      premiumSurface: premiumSurface ?? this.premiumSurface,
      premiumAccent: premiumAccent ?? this.premiumAccent,
      premiumAccentMuted: premiumAccentMuted ?? this.premiumAccentMuted,
      premiumOutline: premiumOutline ?? this.premiumOutline,
      onPremium: onPremium ?? this.onPremium,
      onPremiumMuted: onPremiumMuted ?? this.onPremiumMuted,
      danger: danger ?? this.danger,
      scrim: scrim ?? this.scrim,
    );
  }

  @override
  AppColors lerp(covariant AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      brand: Color.lerp(brand, other.brand, t)!,
      brandMuted: Color.lerp(brandMuted, other.brandMuted, t)!,
      canvas: Color.lerp(canvas, other.canvas, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceMuted: Color.lerp(surfaceMuted, other.surfaceMuted, t)!,
      onCanvas: Color.lerp(onCanvas, other.onCanvas, t)!,
      onCanvasMuted: Color.lerp(onCanvasMuted, other.onCanvasMuted, t)!,
      onCanvasSubtle: Color.lerp(onCanvasSubtle, other.onCanvasSubtle, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      outlineStrong: Color.lerp(outlineStrong, other.outlineStrong, t)!,
      navInactive: Color.lerp(navInactive, other.navInactive, t)!,
      bannerSurface: Color.lerp(bannerSurface, other.bannerSurface, t)!,
      premiumCanvas: Color.lerp(premiumCanvas, other.premiumCanvas, t)!,
      premiumSurface: Color.lerp(premiumSurface, other.premiumSurface, t)!,
      premiumAccent: Color.lerp(premiumAccent, other.premiumAccent, t)!,
      premiumAccentMuted: Color.lerp(
        premiumAccentMuted,
        other.premiumAccentMuted,
        t,
      )!,
      premiumOutline: Color.lerp(premiumOutline, other.premiumOutline, t)!,
      onPremium: Color.lerp(onPremium, other.onPremium, t)!,
      onPremiumMuted: Color.lerp(onPremiumMuted, other.onPremiumMuted, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      scrim: Color.lerp(scrim, other.scrim, t)!,
    );
  }
}
