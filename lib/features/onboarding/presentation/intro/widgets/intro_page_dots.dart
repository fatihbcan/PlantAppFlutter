import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';

/// Page position indicator for the intro [PageView].
class IntroPageDots extends StatelessWidget {
  const IntroPageDots({
    required this.count,
    required this.activeIndex,
    required this.semanticsLabel,
    super.key,
  });

  final int count;
  final int activeIndex;
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final dimens = context.appDimens;
    final colors = context.appColors;

    return Semantics(
      label: semanticsLabel,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(count, (int index) {
          final bool isActive = index == activeIndex;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            margin: EdgeInsets.symmetric(horizontal: dimens.spaceXs),
            height: dimens.spaceSm,
            width: isActive ? dimens.spaceXl : dimens.spaceSm,
            decoration: BoxDecoration(
              color: isActive
                  ? colors.onCanvas
                  : colors.onCanvas.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(dimens.spaceSm),
            ),
          );
        }),
      ),
    );
  }
}
