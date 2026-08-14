/// Every bundled image path, in one place.
///
/// Widgets name an [AppAssets] constant instead of a string literal, so a
/// renamed export is a compile error rather than a blank box at runtime.
///
/// The artwork is the design file's own image fills, pulled at the resolution
/// it stores them. The three care badges ship in the design as one green
/// master that the file tints per placement; they are vendored already tinted,
/// so nothing has to recolour them at runtime. Everything else is cropped to
/// its subject, so a centred fit lands where the design puts it.
abstract final class AppAssets {
  static const String _images = 'assets/images';

  /// Potted monstera on the welcome screen.
  static const String welcomePlant = '$_images/onboarding_welcome_plant.png';

  /// Phone mockup framing the camera, on the "identify" page.
  static const String identifyPhone = '$_images/onboarding_identify_phone.png';

  /// Plant-detail screen shown inside the phone on the "care guides" page.
  static const String careScreen = '$_images/onboarding_care_screen.png';

  /// Floating cards layered over the phone on the "care guides" page.
  static const String careCards = '$_images/onboarding_care_cards.png';

  /// Out-of-focus foliage scattered behind the "care guides" phone.
  static const String leafBlobs = '$_images/leaf_blobs.png';

  /// Hand-drawn stroke under the emphasised words in an intro headline.
  static const String headlineUnderline = '$_images/headline_underline.png';

  /// The three care badges floating around the onboarding artwork.
  static const String badgeSpray = '$_images/badge_spray.png';
  static const String badgeSun = '$_images/badge_sun.png';
  static const String badgeWater = '$_images/badge_water.png';

  /// Full-bleed photo behind the paywall title.
  static const String paywallHero = '$_images/paywall_hero.png';

  /// The two painted leaves tucked behind the home search field.
  static const String headerLeafLeft = '$_images/header_leaf_left.png';
  static const String headerLeafRight = '$_images/header_leaf_right.png';
}
