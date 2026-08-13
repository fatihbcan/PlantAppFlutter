import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';

/// One benefit tile in the paywall's horizontal feature strip.
class PaywallFeatureCard extends StatelessWidget {
  const PaywallFeatureCard({
    required this.icon,
    required this.title,
    required this.body,
    super.key,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final dimens = context.appDimens;

    // Two and a bit cards visible at once on any width, so the strip always
    // reads as scrollable.
    final double width = (MediaQuery.sizeOf(context).width * 0.42).clamp(
      140.0,
      200.0,
    );

    return Container(
      width: width,
      padding: EdgeInsets.all(dimens.spaceLg),
      decoration: BoxDecoration(
        color: colors.premiumSurface,
        borderRadius: BorderRadius.circular(dimens.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: dimens.iconMd, color: colors.onPremium),
          SizedBox(height: dimens.spaceLg),
          Text(
            title,
            style: context.appText.titleMd.copyWith(color: colors.onPremium),
          ),
          SizedBox(height: dimens.spaceXs),
          Text(
            body,
            style: context.appText.bodySm.copyWith(
              color: colors.onPremiumMuted,
            ),
          ),
        ],
      ),
    );
  }
}
