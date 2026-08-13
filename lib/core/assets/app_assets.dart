/// Every bundled image path, in one place.
///
/// Widgets name an [AppAssets] constant instead of a string literal, so a
/// renamed export is a compile error rather than a blank box at runtime.
///
/// The artwork is exported from the case's Figma file at the resolution the
/// design serves it. That caps out around 512px on the longest edge, which
/// covers 1x and 2x at the sizes these images are drawn; a 3x device renders
/// the largest of them slightly soft.
abstract final class AppAssets {
  static const String _images = 'assets/images';

  /// Potted monstera on the welcome screen.
  static const String welcomePlant = '$_images/onboarding_welcome_plant.png';

  /// The three care badges that float around the welcome plant.
  static const String badgeWater = '$_images/badge_water.png';
  static const String badgeSun = '$_images/badge_sun.png';
  static const String badgeSpray = '$_images/badge_spray.png';

  /// Phone mockup framing the camera, on the "identify" page.
  static const String identifyPhone = '$_images/onboarding_identify_phone.png';

  /// Plant-detail screen shown inside the phone on the "care guides" page.
  static const String careScreen = '$_images/onboarding_care_screen.png';

  /// Floating cards layered over the phone on the "care guides" page.
  static const String careCards = '$_images/onboarding_care_cards.png';

  /// Hand-drawn stroke under the emphasised words in an intro headline.
  static const String headlineUnderline = '$_images/headline_underline.png';

  /// Full-bleed photo behind the paywall title.
  static const String paywallHero = '$_images/paywall_hero.png';

  /// Plant bleeding off the right edge of the home header.
  static const String homeHeaderPlant = '$_images/home_header_plant.png';
}
