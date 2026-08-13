import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/assets/app_assets.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';

/// Which illustration an intro page shows.
///
/// The page owns the choice; the widget owns how it is drawn. Keeping this an
/// enum rather than a `Widget` field means the page content stays a plain data
/// bundle that a test can build without a widget tree.
enum IntroArtwork { welcome, identify, careGuides }

/// Badge diameter as a fraction of the artwork's width.
const double _badgeWidthFactor = 0.11;

/// Draws the artwork for one intro page.
///
/// Every piece is laid out as a fraction of the space it is given, so the
/// composition holds its proportions from a small phone to a tablet instead of
/// drifting apart at fixed offsets.
class IntroArtworkView extends StatelessWidget {
  const IntroArtworkView({required this.artwork, super.key});

  final IntroArtwork artwork;

  @override
  Widget build(BuildContext context) {
    return switch (artwork) {
      IntroArtwork.welcome => const _WelcomeArtwork(),
      IntroArtwork.identify => const _IdentifyArtwork(),
      IntroArtwork.careGuides => const _CareGuidesArtwork(),
    };
  }
}

/// The potted plant with the three care badges floating around it.
class _WelcomeArtwork extends StatelessWidget {
  const _WelcomeArtwork();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // The badges scale with the artwork so they stay stickers on the
        // photo rather than growing into buttons on a large screen.
        final double badgeSize = constraints.maxWidth * _badgeWidthFactor;

        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // The export carries wide empty margins, so cover — not contain —
            // is what makes the plant fill the frame the way the design does.
            Image.asset(AppAssets.welcomePlant, fit: BoxFit.cover),
            _Badge(
              alignment: const Alignment(-0.57, -0.70),
              size: badgeSize,
              color: colors.accentViolet,
              icon: Icons.sanitizer_rounded,
            ),
            _Badge(
              alignment: const Alignment(0.56, -0.69),
              size: badgeSize,
              color: colors.accentAmber,
              icon: Icons.wb_sunny_rounded,
            ),
            _Badge(
              alignment: const Alignment(0.34, 0.40),
              size: badgeSize,
              color: colors.accentAzure,
              icon: Icons.water_drop_rounded,
            ),
          ],
        );
      },
    );
  }
}

/// One circular care badge sitting on the welcome photo.
class _Badge extends StatelessWidget {
  const _Badge({
    required this.alignment,
    required this.size,
    required this.color,
    required this.icon,
  });

  final Alignment alignment;
  final double size;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: size * 0.35,
              offset: Offset(0, size * 0.12),
            ),
          ],
        ),
        // Decorative: the surrounding copy already says what the app does, so
        // announcing three icons would only add noise for a screen reader.
        child: ExcludeSemantics(
          child: Icon(
            icon,
            size: size * 0.5,
            color: context.appColors.onPremium,
          ),
        ),
      ),
    );
  }
}

/// The phone mockup framing a plant in the camera viewfinder.
class _IdentifyArtwork extends StatelessWidget {
  const _IdentifyArtwork();

  @override
  Widget build(BuildContext context) {
    // In the design this phone hangs low on the page — open space under the
    // headline, then the mockup cut off by the bottom edge. So it is anchored
    // to the bottom, nudged past it by a fraction of its own height, and
    // clipped there rather than painting over the CTA.
    return const ClipRect(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          widthFactor: _phoneWidthFactor,
          child: FractionalTranslation(
            translation: Offset(0, _bleedFraction),
            child: Image(
              image: AssetImage(AppAssets.identifyPhone),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  static const double _phoneWidthFactor = 0.80;
  static const double _bleedFraction = 0.06;
}

/// A phone showing a plant-care page, with the guide cards floating over it.
class _CareGuidesArtwork extends StatelessWidget {
  const _CareGuidesArtwork();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth;
        final double bezel = width * _bezelFactor;
        final double radius = width * _phoneRadiusFactor;

        // The phone is taller than the space it is given: it is anchored to
        // the top and cut off at the bottom, exactly as the design has it
        // running past the edge of the screen.
        return ClipRect(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: FractionallySizedBox(
                  widthFactor: _phoneWidthFactor,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.onCanvas,
                      borderRadius: BorderRadius.circular(radius),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(bezel),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radius - bezel),
                        child: Image.asset(
                          AppAssets.careScreen,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.95, -0.85),
                child: FractionallySizedBox(
                  widthFactor: _cardsWidthFactor,
                  child: Image.asset(AppAssets.careCards, fit: BoxFit.contain),
                ),
              ),
              _Badge(
                alignment: const Alignment(0.34, -0.95),
                size: width * _badgeWidthFactor,
                color: colors.accentViolet,
                icon: Icons.sanitizer_rounded,
              ),
              _Badge(
                alignment: const Alignment(1.0, -0.72),
                size: width * _badgeWidthFactor * 0.66,
                color: colors.accentAmber,
                icon: Icons.wb_sunny_rounded,
              ),
            ],
          ),
        );
      },
    );
  }

  static const double _phoneWidthFactor = 0.72;
  static const double _cardsWidthFactor = 0.36;
  static const double _bezelFactor = 0.012;
  static const double _phoneRadiusFactor = 0.075;
}
