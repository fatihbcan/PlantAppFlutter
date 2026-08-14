import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/icons/app_icons.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';

/// The dark "FREE Premium Available" strip under the search field.
///
/// Every value here — the flat `#24201A` ground, the two golds, the envelope
/// illustration — is taken from the design's own export rather than matched
/// by eye.
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
          height: _height,
          padding: EdgeInsets.symmetric(horizontal: dimens.spaceLg),
          decoration: BoxDecoration(
            color: colors.bannerSurface,
            borderRadius: BorderRadius.circular(dimens.radiusMd),
          ),
          child: Row(
            children: <Widget>[
              AppIconView(
                icon: AppIcon.envelope,
                size: _envelopeWidth,
                height: _envelopeWidth * _envelopeAspect,
                color: colors.premiumAccent,
              ),
              SizedBox(width: dimens.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.appText.titleSm.copyWith(
                        color: colors.premiumAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: dimens.spaceXxs),
                    Text(
                      body,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.appText.bodySm.copyWith(
                        fontSize: 13,
                        color: colors.premiumAccentMuted,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: dimens.spaceSm),
              AppIconView(
                icon: AppIcon.chevronRight,
                size: _chevronSize,
                color: colors.premiumAccentMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const double _height = 66;
  static const double _chevronSize = 20;
  static const double _envelopeWidth = 44;

  /// Height over width of the exported illustration, badge included.
  static const double _envelopeAspect = 48 / 52;
}
