import 'package:flutter/material.dart';

/// The design's own glyphs, exported from the Figma file.
///
/// None of these exist in Material's icon set — the viewfinder, the lidded
/// jar, the diagnose shield, the garden leaf and the dial are drawn for this
/// product — and hand-approximating them is exactly what made the bottom bar
/// and the paywall's feature strip read wrong. These are the file's own
/// exports, so the shapes are the design's rather than a likeness of it.
///
/// All but [envelope] are single-colour masters, so the widget tints them
/// from the theme; the envelope is a full-colour illustration and is drawn as
/// exported.
enum AppIcon {
  /// Viewfinder around a card — plant identification.
  scan('scan.webp'),

  /// Dial — faster processing.
  gauge('speedometer.webp'),

  /// Leaf — the "My Garden" destination, and plant care on the paywall.
  leaf('nav_garden.webp'),

  /// Lidded jar — the "Home" destination.
  pot('nav_home.webp'),

  /// Shield with a cross — the "Diagnose" destination.
  shieldPlus('nav_diagnose.webp'),

  /// Bust — the "Profile" destination.
  person('nav_profile.webp'),

  /// Magnifier — the home search field.
  search('search.webp'),

  /// Chevron — the premium strip's affordance.
  chevronRight('chevron_right.webp'),

  /// Cross — the paywall's close control, and clearing the search field.
  close('close.webp'),

  /// The gilded envelope and its unread counter, on the premium strip. Full
  /// colour, so [AppIconView.color] does not apply to it.
  envelope('envelope_badge.webp', isTintable: false),

  /// The paywall's three feature tiles. The design ships these as complete
  /// marks — the tinted ground and the glyph together — so they are drawn
  /// whole rather than rebuilt from a bare glyph on a box of our own.
  featureUnlimited('feature_unlimited.webp', isTintable: false),
  featureFaster('feature_faster.webp', isTintable: false),
  featureDetailed('feature_detailed.webp', isTintable: false);

  const AppIcon(this._file, {this.isTintable = true});

  final String _file;

  /// Whether the glyph is a single-colour master the theme may recolour.
  final bool isTintable;

  String get assetPath => 'assets/icons/$_file';
}

/// Draws one [AppIcon] at [size], tinted [color] where the glyph allows it.
class AppIconView extends StatelessWidget {
  const AppIconView({
    required this.icon,
    required this.size,
    required this.color,
    this.height,
    super.key,
  });

  final AppIcon icon;

  /// The glyph's width. Square unless [height] says otherwise.
  final double size;

  /// Set only for glyphs the design does not draw square, such as the
  /// envelope.
  final double? height;

  /// Ignored when the glyph is not tintable — see [AppIcon.isTintable].
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      icon.assetPath,
      width: size,
      height: height ?? size,
      color: icon.isTintable ? color : null,
      // Icons are always labelled by the control around them, so announcing
      // the drawing itself would only duplicate that label.
      excludeFromSemantics: true,
    );
  }
}
