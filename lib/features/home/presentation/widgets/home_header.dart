import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/assets/app_assets.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';
import 'package:hubx_flutter_case/features/home/presentation/widgets/home_search_field.dart';

/// The tinted band at the top of home: greeting, search, and the plant that
/// bleeds off the right edge behind them.
///
/// The band runs to the screen edges, so it is laid out outside the page
/// gutter and carries its own padding.
class HomeHeader extends StatelessWidget {
  const HomeHeader({
    required this.greeting,
    required this.salutation,
    required this.searchHint,
    required this.onSearchChanged,
    required this.onSearchCleared,
    super.key,
  });

  final String greeting;
  final String salutation;
  final String searchHint;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onSearchCleared;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final dimens = context.appDimens;
    final double width = MediaQuery.sizeOf(context).width;

    return ClipRect(
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: ColoredBox(color: colors.brandMuted)),
          // The plant is given more height than the band and clipped to it, so
          // the band's edge cuts through foliage rather than through the pot.
          Positioned(
            top: 0,
            bottom: -width * _plantOverhangFactor,
            right: -width * _plantBleedFactor,
            child: SizedBox(
              width: width * _plantWidthFactor,
              child: Image.asset(
                AppAssets.homeHeaderPlant,
                // Cover, so the band crops the pot and its stand away and keeps
                // the foliage — which is all the design shows of it.
                fit: BoxFit.cover,
                alignment: Alignment.topRight,
                // Decorative: the greeting beside it already carries the meaning.
                excludeFromSemantics: true,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              dimens.pageGutter,
              dimens.spaceLg,
              dimens.pageGutter,
              dimens.spaceLg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  greeting,
                  style: context.appText.bodyMd.copyWith(
                    color: colors.onCanvas,
                  ),
                ),
                SizedBox(height: dimens.spaceXxs),
                Text(
                  salutation,
                  style: context.appText.titleLg.copyWith(
                    color: colors.onCanvas,
                  ),
                ),
                SizedBox(height: dimens.spaceLg),
                HomeSearchField(
                  hintText: searchHint,
                  onChanged: onSearchChanged,
                  onCleared: onSearchCleared,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Plant width, how far it hangs past the right edge, and how far it runs
  /// below the band before being clipped — all fractions of the screen width
  /// so the composition holds on any size.
  static const double _plantWidthFactor = 0.46;
  static const double _plantBleedFactor = 0.06;
  static const double _plantOverhangFactor = 0.34;
}
