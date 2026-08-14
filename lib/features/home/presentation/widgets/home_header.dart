import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/assets/app_assets.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';
import 'package:hubx_flutter_case/features/home/presentation/widgets/home_search_field.dart';

/// The band at the top of home: greeting, search, and the two painted leaves
/// tucked in behind them.
///
/// The band is the page colour, not a tint — what separates it from the
/// content below is the artwork, which is clipped off at the band's lower
/// edge. It runs to the screen edges, so it is laid out outside the page
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
          Positioned.fill(child: ColoredBox(color: colors.canvas)),
          // Both leaves are anchored to the band's lower edge and run past it,
          // so the clip cuts them exactly where the design does.
          Positioned(
            left: -width * 0.05,
            bottom: -width * 0.14,
            width: width * 0.38,
            child: const Image(
              image: AssetImage(AppAssets.headerLeafLeft),
              fit: BoxFit.contain,
              excludeFromSemantics: true,
            ),
          ),
          Positioned(
            right: -width * 0.06,
            bottom: -width * 0.13,
            width: width * 0.34,
            child: const Image(
              image: AssetImage(AppAssets.headerLeafRight),
              fit: BoxFit.contain,
              excludeFromSemantics: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              dimens.pageGutter,
              dimens.spaceXl,
              dimens.pageGutter,
              dimens.spaceLg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  greeting,
                  style: context.appText.bodyLg.copyWith(
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
}
