import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/icons/app_icons.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';
import 'package:hubx_flutter_case/l10n/gen/app_localizations.dart';

/// The five-destination bar from the home design, with the scan control
/// raised in the middle.
///
/// Only Home has a screen in this case, so the other destinations render but
/// do not respond — they are labelled as disabled rather than pretending to
/// be buttons that silently do nothing.
class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({required this.onScanPressed, super.key});

  final VoidCallback onScanPressed;

  @override
  Widget build(BuildContext context) {
    final AppL10n l10n = AppL10n.of(context);
    final colors = context.appColors;

    return SizedBox(
      // Room above the bar for the scan button to sit proud of it.
      height: _barHeight + _scanOverhang + MediaQuery.paddingOf(context).bottom,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colors.surface,
                border: Border(top: BorderSide(color: colors.outline)),
              ),
              child: SafeArea(
                top: false,
                child: SizedBox(
                  height: _barHeight,
                  child: Row(
                    children: <Widget>[
                      _Destination(
                        icon: AppIcon.pot,
                        label: l10n.navHome,
                        isCurrent: true,
                      ),
                      _Destination(
                        icon: AppIcon.shieldPlus,
                        label: l10n.navDiagnose,
                        isCurrent: false,
                      ),
                      // The gap the scan button sits in — one column wide, so
                      // the four labels stay on the design's fifths.
                      const Spacer(),
                      _Destination(
                        icon: AppIcon.leaf,
                        label: l10n.navMyGarden,
                        isCurrent: false,
                      ),
                      _Destination(
                        icon: AppIcon.person,
                        label: l10n.navProfile,
                        isCurrent: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: _ScanButton(
              semanticsLabel: l10n.navScan,
              onPressed: onScanPressed,
            ),
          ),
        ],
      ),
    );
  }

  static const double _barHeight = 64;
  static const double _scanOverhang = 24;
}

/// One labelled destination in the bar.
class _Destination extends StatelessWidget {
  const _Destination({
    required this.icon,
    required this.label,
    required this.isCurrent,
  });

  final AppIcon icon;
  final String label;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final dimens = context.appDimens;
    final Color tint = isCurrent ? colors.brand : colors.navInactive;

    return Expanded(
      child: Semantics(
        selected: isCurrent,
        enabled: isCurrent,
        label: label,
        excludeSemantics: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppIconView(icon: icon, size: dimens.iconMd, color: tint),
            SizedBox(height: dimens.spaceXs),
            Text(label, style: context.appText.bodySm.copyWith(color: tint)),
          ],
        ),
      ),
    );
  }
}

/// The raised scan control in the middle of the bar.
class _ScanButton extends StatelessWidget {
  const _ScanButton({required this.semanticsLabel, required this.onPressed});

  final String semanticsLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Semantics(
      button: true,
      label: semanticsLabel,
      excludeSemantics: true,
      // The design rings the button in a lighter green so it reads as lifted
      // off the bar rather than punched through it.
      child: Container(
        width: _size,
        height: _size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors.brand.withValues(alpha: 0.35),
        ),
        padding: const EdgeInsets.all(_ringWidth),
        child: Material(
          color: colors.brand,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onPressed,
            child: Center(
              child: AppIconView(
                icon: AppIcon.scan,
                size: _glyphSize,
                color: colors.onPremium,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static const double _size = 64;
  static const double _ringWidth = 4;
  static const double _glyphSize = 26;
}
