import 'package:flutter/material.dart';
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
    final dimens = context.appDimens;

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
                        icon: Icons.home_rounded,
                        label: l10n.navHome,
                        isCurrent: true,
                      ),
                      _Destination(
                        icon: Icons.health_and_safety_outlined,
                        label: l10n.navDiagnose,
                        isCurrent: false,
                      ),
                      // The gap the scan button sits in.
                      SizedBox(width: dimens.spaceXxl * 2),
                      _Destination(
                        icon: Icons.local_florist_outlined,
                        label: l10n.navMyGarden,
                        isCurrent: false,
                      ),
                      _Destination(
                        icon: Icons.person_outline_rounded,
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
  static const double _scanOverhang = 20;
}

/// One labelled destination in the bar.
class _Destination extends StatelessWidget {
  const _Destination({
    required this.icon,
    required this.label,
    required this.isCurrent,
  });

  final IconData icon;
  final String label;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final Color tint = isCurrent ? colors.brand : colors.onCanvasSubtle;

    return Expanded(
      child: Semantics(
        selected: isCurrent,
        enabled: isCurrent,
        label: label,
        excludeSemantics: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: context.appDimens.iconMd, color: tint),
            SizedBox(height: context.appDimens.spaceXxs),
            Text(label, style: context.appText.caption.copyWith(color: tint)),
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
      child: Material(
        color: colors.brand,
        shape: const CircleBorder(),
        elevation: _elevation,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: SizedBox(
            width: _size,
            height: _size,
            child: Icon(
              Icons.document_scanner_outlined,
              color: colors.onPremium,
              size: context.appDimens.iconMd,
            ),
          ),
        ),
      ),
    );
  }

  static const double _size = 60;
  static const double _elevation = 4;
}
