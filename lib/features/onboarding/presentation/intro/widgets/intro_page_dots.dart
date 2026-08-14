import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';

/// Page position indicator for the intro [PageView].
///
/// The design uses round dots that change size and tone, not a stretching
/// pill — the current page is a larger, near-black dot among smaller grey
/// ones.
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
    final colors = context.appColors;

    return Semantics(
      label: semanticsLabel,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(count, (int index) {
          final bool isActive = index == activeIndex;
          final double size = isActive ? _activeSize : _inactiveSize;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            margin: const EdgeInsets.symmetric(horizontal: _gap / 2),
            height: size,
            width: size,
            decoration: BoxDecoration(
              color: isActive
                  ? colors.onCanvas
                  : colors.onCanvas.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }

  static const double _activeSize = 10;
  static const double _inactiveSize = 6;
  static const double _gap = 10;
}
