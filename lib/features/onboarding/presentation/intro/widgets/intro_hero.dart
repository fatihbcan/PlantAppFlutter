import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';

/// Illustration block at the top of an intro page.
///
/// Takes a primitive [icon] and a [tone] rather than a page object, so it
/// stays reusable and const-constructible.
class IntroHero extends StatelessWidget {
  const IntroHero({required this.icon, required this.isRounded, super.key});

  final IconData icon;

  /// The first page runs the artwork edge to edge; later pages round it.
  final bool isRounded;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final double radius = isRounded ? context.appDimens.radiusXl : 0;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            colors.brand.withValues(alpha: 0.18),
            colors.brandMuted,
          ],
        ),
      ),
      child: Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            // Artwork scales with the box instead of a fixed pixel size, so
            // the hero reads the same on a 4" phone and a tablet.
            final double side = constraints.biggest.shortestSide * 0.42;
            return Icon(icon, size: side, color: colors.brand);
          },
        ),
      ),
    );
  }
}
