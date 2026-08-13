import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';

/// A selectable plan row on the paywall.
///
/// Primitives only — the tile knows nothing about the plan entity.
class PaywallPlanTile extends StatelessWidget {
  const PaywallPlanTile({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
    this.badge,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  /// Optional "save 50%" style pill.
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final dimens = context.appDimens;

    return Semantics(
      button: true,
      selected: isSelected,
      label: '$title, $subtitle',
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(dimens.radiusLg),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: EdgeInsets.all(dimens.spaceLg),
          decoration: BoxDecoration(
            color: colors.premiumSurface,
            borderRadius: BorderRadius.circular(dimens.radiusLg),
            border: Border.all(
              color: isSelected ? colors.brand : colors.premiumOutline,
              width: isSelected ? dimens.strokeThick : dimens.strokeThin,
            ),
          ),
          child: Row(
            children: <Widget>[
              _SelectionDot(isSelected: isSelected),
              SizedBox(width: dimens.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      title,
                      style: context.appText.titleSm.copyWith(
                        color: colors.onPremium,
                      ),
                    ),
                    SizedBox(height: dimens.spaceXxs),
                    Text(
                      subtitle,
                      style: context.appText.bodySm.copyWith(
                        color: colors.onPremiumMuted,
                      ),
                    ),
                  ],
                ),
              ),
              if (badge != null) _PlanBadge(label: badge!),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectionDot extends StatelessWidget {
  const _SelectionDot({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final double size = context.appDimens.iconSm + context.appDimens.spaceXs;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? colors.brand : colors.premiumOutline,
          width: context.appDimens.strokeThick,
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: size / 2.4,
                height: size / 2.4,
                decoration: BoxDecoration(
                  color: colors.brand,
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }
}

class _PlanBadge extends StatelessWidget {
  const _PlanBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final dimens = context.appDimens;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: dimens.spaceSm,
        vertical: dimens.spaceXs,
      ),
      decoration: BoxDecoration(
        color: context.appColors.brand,
        borderRadius: BorderRadius.circular(dimens.radiusSm),
      ),
      child: Text(
        label,
        style: context.appText.caption.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
