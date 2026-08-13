import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';

/// The gold "FREE Premium Available" strip under the search field.
class HomePremiumBanner extends StatelessWidget {
  const HomePremiumBanner({
    required this.title,
    required this.body,
    required this.onTap,
    super.key,
  });

  final String title;
  final String body;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final dimens = context.appDimens;

    return Semantics(
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(dimens.radiusMd),
        child: Container(
          padding: EdgeInsets.all(dimens.spaceMd),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(dimens.radiusMd),
            gradient: LinearGradient(
              colors: <Color>[colors.premiumCanvas, colors.premiumSurface],
            ),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.workspace_premium_rounded,
                color: colors.premiumAccent,
                size: dimens.iconMd,
              ),
              SizedBox(width: dimens.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      title,
                      style: context.appText.titleSm.copyWith(
                        color: colors.premiumAccent,
                      ),
                    ),
                    SizedBox(height: dimens.spaceXxs),
                    Text(
                      body,
                      style: context.appText.bodySm.copyWith(
                        color: colors.onPremiumMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: colors.premiumAccent,
                size: dimens.iconMd,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
