import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/icons/app_icons.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';

/// One benefit tile in the paywall's horizontal feature strip.
class PaywallFeatureCard extends StatelessWidget {
  const PaywallFeatureCard({
    required this.icon,
    required this.title,
    required this.body,
    super.key,
  });

  final AppIcon icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final dimens = context.appDimens;

    // Two and a bit cards visible at once on any width, so the strip always
    // reads as scrollable.
    final double width = (MediaQuery.sizeOf(context).width * 0.43).clamp(
      140.0,
      200.0,
    );

    return Container(
      width: width,
      padding: EdgeInsets.all(dimens.spaceLg),
      decoration: BoxDecoration(
        // A wash of white rather than a flat colour: the strip sits over the
        // hero's fade, and a solid panel would band against it.
        color: colors.onPremium.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(dimens.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppIconView(icon: icon, size: _iconTileSize, color: colors.onPremium),
          SizedBox(height: dimens.spaceMd),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.appText.titleMd.copyWith(
              color: colors.onPremium,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: dimens.spaceXxs),
          Text(
            body,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.appText.bodySm.copyWith(
              fontSize: 13,
              color: colors.onPremiumMuted,
            ),
          ),
        ],
      ),
    );
  }

  static const double _iconTileSize = 36;
}
