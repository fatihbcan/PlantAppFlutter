import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hubx_flutter_case/core/assets/app_assets.dart';
import 'package:hubx_flutter_case/core/icons/app_icons.dart';
import 'package:hubx_flutter_case/core/theme/app_typography.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/entity/subscription_plan.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/paywall/bloc/paywall_bloc.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/paywall/widgets/paywall_feature_card.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/paywall/widgets/paywall_plan_tile.dart';
import 'package:hubx_flutter_case/l10n/gen/app_localizations.dart';
import 'package:hubx_flutter_case/shared/widgets/app_error_view.dart';
import 'package:hubx_flutter_case/shared/widgets/app_loader.dart';
import 'package:hubx_flutter_case/shared/widgets/app_primary_button.dart';

/// Paywall layout: hero, benefits, plans, CTA and legal footer.
///
/// The premium palette is used regardless of platform brightness — this
/// screen is dark by design in both themes.
class PaywallView extends StatelessWidget {
  const PaywallView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppL10n l10n = AppL10n.of(context);
    final dimens = context.appDimens;
    final colors = context.appColors;

    return BlocBuilder<PaywallBloc, PaywallState>(
      builder: (BuildContext context, PaywallState state) {
        if (state.isInitialLoading) {
          return AppLoader(color: colors.brand);
        }

        if (!state.hasPlans && state.error == PaywallError.plansUnavailable) {
          return Center(
            child: AppErrorView(
              message: l10n.commonUnknownError,
              retryLabel: l10n.commonRetry,
              onRetry: () =>
                  context.read<PaywallBloc>().add(const PaywallEvent.started()),
            ),
          );
        }

        return Stack(
          children: <Widget>[
            CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(child: _Hero(l10n: l10n)),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    dimens.pageGutter,
                    dimens.spaceXl,
                    dimens.pageGutter,
                    0,
                  ),
                  sliver: SliverList.separated(
                    itemCount: state.plans.length,
                    separatorBuilder: (_, _) =>
                        SizedBox(height: dimens.spaceLg),
                    itemBuilder: (BuildContext context, int index) {
                      final SubscriptionPlan plan = state.plans[index];
                      return PaywallPlanTile(
                        title: _planTitle(l10n, plan),
                        subtitle: _planSubtitle(l10n, plan),
                        isSelected: plan.id == state.selectedPlanId,
                        badge: plan.hasDiscount ? l10n.paywallPlanBadge : null,
                        onTap: () => context.read<PaywallBloc>().add(
                          PaywallEvent.planSelected(plan.id),
                        ),
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: _Footer(state: state, l10n: l10n),
                ),
              ],
            ),
            _CloseButton(l10n: l10n),
          ],
        );
      },
    );
  }

  String _planTitle(AppL10n l10n, SubscriptionPlan plan) =>
      switch (plan.period) {
        BillingPeriod.monthly => l10n.paywallPlanMonthlyTitle,
        BillingPeriod.yearly => l10n.paywallPlanYearlyTitle,
      };

  String _planSubtitle(AppL10n l10n, SubscriptionPlan plan) =>
      switch (plan.period) {
        BillingPeriod.monthly => l10n.paywallPlanMonthlyBody(
          plan.formattedPrice,
        ),
        BillingPeriod.yearly => l10n.paywallPlanYearlyBody(plan.formattedPrice),
      };
}

/// The photo, the title over it, and the feature strip sitting on its lower
/// edge.
///
/// The design overlaps all three inside the photo's own box rather than
/// stacking them down the page, which is why this is a [Stack] and not a
/// column of sections.
class _Hero extends StatelessWidget {
  const _Hero({required this.l10n});

  final AppL10n l10n;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final dimens = context.appDimens;

    return AspectRatio(
      aspectRatio: _heroAspectRatio,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            AppAssets.paywallHero,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            excludeFromSemantics: true,
          ),
          // The export already fades towards black; this carries that fade the
          // rest of the way into the page colour so there is no visible seam,
          // and darkens the ground the title and cards sit on.
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const <double>[_fadeStart, 1],
                colors: <Color>[
                  colors.premiumCanvas.withValues(alpha: 0),
                  colors.premiumCanvas,
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: dimens.pageGutter),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _PremiumTitle(l10n: l10n),
                      SizedBox(height: dimens.spaceXs),
                      Text(
                        l10n.paywallSubtitle,
                        style: context.appText.bodyMd.copyWith(
                          color: colors.onPremiumMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: dimens.spaceXl),
                _Features(l10n: l10n),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// The export's own proportions — the design runs it edge to edge and lets
  /// the feature strip finish on its bottom edge.
  static const double _heroAspectRatio = 375 / 470;

  /// Where the fade into the page colour begins, down the hero.
  static const double _fadeStart = 0.45;
}

/// "PlantApp Premium", with the product name carrying the weight.
class _PremiumTitle extends StatelessWidget {
  const _PremiumTitle({required this.l10n});

  final AppL10n l10n;

  @override
  Widget build(BuildContext context) {
    final TextStyle base = context.appText.displayMd.copyWith(
      color: context.appColors.onPremium,
    );
    final int split = l10n.paywallTitle.indexOf(l10n.appTitle);

    if (split < 0) return Text(l10n.paywallTitle, style: base);

    return Text.rich(
      TextSpan(
        style: base,
        children: <InlineSpan>[
          TextSpan(
            text: l10n.appTitle,
            style: base.copyWith(fontWeight: AppTypography.emphasis),
          ),
          TextSpan(
            text: l10n.paywallTitle.substring(split + l10n.appTitle.length),
          ),
        ],
      ),
      semanticsLabel: l10n.paywallTitle,
    );
  }
}

class _Features extends StatelessWidget {
  const _Features({required this.l10n});

  final AppL10n l10n;

  @override
  Widget build(BuildContext context) {
    final dimens = context.appDimens;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: dimens.pageGutter),
      child: Row(
        children: <Widget>[
          PaywallFeatureCard(
            icon: AppIcon.featureUnlimited,
            title: l10n.paywallFeatureUnlimitedTitle,
            body: l10n.paywallFeatureUnlimitedBody,
          ),
          SizedBox(width: dimens.spaceMd),
          PaywallFeatureCard(
            icon: AppIcon.featureFaster,
            title: l10n.paywallFeatureFasterTitle,
            body: l10n.paywallFeatureFasterBody,
          ),
          SizedBox(width: dimens.spaceMd),
          PaywallFeatureCard(
            icon: AppIcon.featureDetailed,
            title: l10n.paywallFeatureDetailedTitle,
            body: l10n.paywallFeatureDetailedBody,
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.state, required this.l10n});

  final PaywallState state;
  final AppL10n l10n;

  @override
  Widget build(BuildContext context) {
    final dimens = context.appDimens;
    final colors = context.appColors;
    final String price = state.selectedPlan?.formattedPrice ?? '';

    return Padding(
      // viewPadding rather than padding: this page draws under the system
      // bars on purpose, so the inset it has to clear is the raw one. Without
      // it the legal copy ends up beneath the navigation bar.
      padding: EdgeInsets.fromLTRB(
        dimens.pageGutter,
        dimens.spaceLg,
        dimens.pageGutter,
        dimens.spaceMd + MediaQuery.viewPaddingOf(context).bottom,
      ),
      child: Column(
        children: <Widget>[
          AppPrimaryButton(
            label: l10n.paywallCta,
            isLoading: state.isSubmitting,
            onPressed: state.canSubmit
                ? () => context.read<PaywallBloc>().add(
                    const PaywallEvent.subscribePressed(),
                  )
                : null,
          ),
          SizedBox(height: dimens.spaceMd),
          Text(
            l10n.paywallLegal(price),
            textAlign: TextAlign.center,
            style: context.appText.caption.copyWith(
              fontSize: 9,
              color: colors.onPremiumMuted.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(height: dimens.spaceSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _FooterLink(label: l10n.paywallTerms),
              const _FooterDot(),
              _FooterLink(label: l10n.paywallPrivacy),
              const _FooterDot(),
              _FooterLink(label: l10n.paywallRestore),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: context.appText.caption.copyWith(
        color: context.appColors.onPremiumMuted.withValues(alpha: 0.85),
      ),
    );
  }
}

class _FooterDot extends StatelessWidget {
  const _FooterDot();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.appDimens.spaceSm),
      child: Text(
        '•',
        style: context.appText.caption.copyWith(
          color: context.appColors.onPremiumMuted.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

/// The control that actually ends onboarding, per the case brief.
class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.l10n});

  final AppL10n l10n;

  @override
  Widget build(BuildContext context) {
    final dimens = context.appDimens;

    return Positioned(
      top: MediaQuery.viewPaddingOf(context).top + dimens.spaceSm,
      right: dimens.pageGutter,
      child: Semantics(
        button: true,
        label: l10n.paywallCloseSemantics,
        child: Material(
          color: Colors.black.withValues(alpha: 0.45),
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => context.read<PaywallBloc>().add(
              const PaywallEvent.closePressed(),
            ),
            child: SizedBox.square(
              dimension: _size,
              child: Center(
                child: AppIconView(
                  icon: AppIcon.close,
                  size: dimens.iconSm,
                  color: context.appColors.onPremium,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static const double _size = 32;
}
