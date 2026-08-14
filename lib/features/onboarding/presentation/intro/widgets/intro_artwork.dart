import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/assets/app_assets.dart';
import 'package:hubx_flutter_case/shared/widgets/scan_frame.dart';

/// Which illustration an intro page shows.
///
/// The page owns the choice; the widget owns how it is drawn. Keeping this an
/// enum rather than a `Widget` field means the page content stays a plain data
/// bundle that a test can build without a widget tree.
enum IntroArtwork { welcome, identify, careGuides }

/// Draws the artwork for one intro page.
///
/// Every piece is laid out as a fraction of the space it is given, taken from
/// the design's own proportions, so the composition holds from a small phone
/// to a tablet instead of drifting apart at fixed offsets.
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

/// The potted plant, the viewfinder over it, and the three care badges.
class _WelcomeArtwork extends StatelessWidget {
  const _WelcomeArtwork();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth;
        final double height = constraints.maxHeight;

        // The plant is laid out explicitly rather than through an Align, so
        // the badges can hang off its rendered rect. In the design they are
        // pinned to the plant, not to the page, and anchoring them to the box
        // instead is what let them drift.
        final double plantHeight = height * _plantHeightFactor;
        final double plantWidth = plantHeight * _plantAspect;
        final double plantLeft = (width - plantWidth) / 2;
        final double plantTop = height * _plantTopFactor;

        Widget badge(String asset, double cx, double cy, double scale) {
          final double size = plantWidth * scale;
          return Positioned(
            left: plantLeft + plantWidth * cx - size / 2,
            top: plantTop + plantHeight * cy - size / 2,
            width: size,
            child: Image.asset(
              asset,
              fit: BoxFit.contain,
              excludeFromSemantics: true,
            ),
          );
        }

        return Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              left: plantLeft,
              top: plantTop,
              width: plantWidth,
              height: plantHeight,
              child: const Image(
                image: AssetImage(AppAssets.welcomePlant),
                fit: BoxFit.fill,
                excludeFromSemantics: true,
              ),
            ),
            const Align(
              alignment: Alignment(0, -0.225),
              child: FractionallySizedBox(
                widthFactor: 0.62,
                heightFactor: 0.44,
                child: ScanFrame(),
              ),
            ),
            badge(AppAssets.badgeSpray, 0.109, 0.126, 0.212),
            badge(AppAssets.badgeSun, 0.883, 0.135, 0.154),
            badge(AppAssets.badgeWater, 0.737, 0.824, 0.116),
          ],
        );
      },
    );
  }

  /// The plant export's own aspect, and where its box sits in the artwork
  /// area — both taken from the design.
  static const double _plantAspect = 200 / 332;
  static const double _plantHeightFactor = 0.87;
  static const double _plantTopFactor = 0.026;
}

/// One care badge sitting on the artwork.
///
/// The badges are exported already tinted, so this only has to place and size
/// them. They are decorative — the copy beside them already says what the app
/// does — so they carry no semantics.
class _Badge extends StatelessWidget {
  const _Badge({
    required this.alignment,
    required this.size,
    required this.asset,
  });

  final Alignment alignment;
  final double size;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Image.asset(
        asset,
        width: size,
        fit: BoxFit.contain,
        excludeFromSemantics: true,
      ),
    );
  }
}

/// The phone mockup with the plant growing out behind it and the viewfinder
/// over its camera preview.
class _IdentifyArtwork extends StatelessWidget {
  const _IdentifyArtwork();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth;
        final double height = constraints.maxHeight;

        // The phone's own proportions, from the export.
        final double phoneWidth = width * _phoneWidthFactor;
        final double phoneHeight = phoneWidth * _phoneAspect;

        return Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            // The plant stands behind the phone and only its crown shows,
            // which is what the design's silhouette depends on.
            Positioned(
              left: (width - phoneWidth * 0.72) / 2,
              width: phoneWidth * 0.72,
              top: 0,
              height: height - phoneHeight * 0.62,
              child: const Image(
                image: AssetImage(AppAssets.welcomePlant),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                excludeFromSemantics: true,
              ),
            ),
            Positioned(
              left: (width - phoneWidth) / 2,
              // The design leaves a little air under this phone, unlike the
              // care-guides one which runs behind the CTA.
              bottom: height * _phoneLiftFactor,
              width: phoneWidth,
              height: phoneHeight,
              child: Stack(
                children: <Widget>[
                  const Positioned.fill(
                    child: Image(
                      image: AssetImage(AppAssets.identifyPhone),
                      fit: BoxFit.contain,
                      excludeFromSemantics: true,
                    ),
                  ),
                  Positioned(
                    left: phoneWidth * 0.02,
                    right: phoneWidth * 0.02,
                    top: phoneHeight * 0.16,
                    height: phoneHeight * 0.45,
                    child: const ScanFrame(strokeWidth: 3),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  static const double _phoneWidthFactor = 0.69;
  static const double _phoneLiftFactor = 0.05;

  /// Height over width of the cropped phone export.
  static const double _phoneAspect = 320 / 197;
}

/// A phone showing a plant-care page, with the guide cards floating over it
/// and out-of-focus foliage scattered behind.
class _CareGuidesArtwork extends StatelessWidget {
  const _CareGuidesArtwork();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth;
        final double phoneWidth = width * _phoneWidthFactor;
        final double bezel = phoneWidth * _bezelFactor;
        final double radius = phoneWidth * _phoneRadiusFactor;

        return Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            // The blurred leaves the design scatters behind everything. The
            // export is only softly out of focus; the extra blur is what turns
            // it into the green haze on the page.
            Positioned.fill(
              child: ImageFiltered(
                imageFilter: ui.ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                child: const Opacity(
                  opacity: 0.85,
                  child: Image(
                    image: AssetImage(AppAssets.leafBlobs),
                    fit: BoxFit.cover,
                    excludeFromSemantics: true,
                  ),
                ),
              ),
            ),
            // The phone runs off the bottom of the page, stopping at the CTA.
            Positioned(
              left: (width - phoneWidth) / 2,
              top: constraints.maxHeight * _phoneTopFactor,
              bottom: 0,
              width: phoneWidth,
              child: ClipRRect(
                // Square at the bottom: the phone runs behind the CTA rather
                // than stopping above it, so rounding there leaves a gap.
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(radius),
                ),
                child: ColoredBox(
                  color: const Color(0xFF0B0B0B),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(bezel, bezel, bezel, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(radius - bezel),
                      ),
                      child: Image.asset(
                        AppAssets.careScreen,
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                        excludeFromSemantics: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.98, -0.86),
              child: FractionallySizedBox(
                widthFactor: _cardsWidthFactor,
                child: Image.asset(
                  AppAssets.careCards,
                  fit: BoxFit.contain,
                  excludeFromSemantics: true,
                ),
              ),
            ),
            _Badge(
              alignment: const Alignment(0.30, -0.98),
              size: width * 0.095,
              asset: AppAssets.badgeSpray,
            ),
            _Badge(
              alignment: const Alignment(0.96, -0.80),
              size: width * 0.075,
              asset: AppAssets.badgeSun,
            ),
          ],
        );
      },
    );
  }

  static const double _phoneWidthFactor = 0.72;
  static const double _cardsWidthFactor = 0.40;
  static const double _bezelFactor = 0.035;
  static const double _phoneRadiusFactor = 0.13;

  /// Where the phone's top edge sits down the artwork box.
  static const double _phoneTopFactor = 0.10;
}
