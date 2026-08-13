import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                SliverToBoxAdapter(child: _Features(l10n: l10n)),
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
                        SizedBox(height: dimens.spaceMd),
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

class _Hero extends StatelessWidget {
  const _Hero({required this.l10n});

  final AppL10n l10n;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final dimens = context.appDimens;
    final double height = MediaQuery.sizeOf(context).height * 0.34;

    return SizedBox(
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[colors.premiumSurface, colors.premiumCanvas],
              ),
            ),
          ),
          Center(
            child: Icon(
              Icons.local_florist_rounded,
              size: height * 0.34,
              color: colors.brand,
            ),
          ),
          Positioned(
            left: dimens.pageGutter,
            right: dimens.pageGutter,
            bottom: dimens.spaceLg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  l10n.paywallTitle,
                  style: context.appText.displayMd.copyWith(
                    color: colors.onPremium,
                  ),
                ),
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
        ],
      ),
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
            icon: Icons.all_inclusive_rounded,
            title: l10n.paywallFeatureUnlimitedTitle,
            body: l10n.paywallFeatureUnlimitedBody,
          ),
          SizedBox(width: dimens.spaceMd),
          PaywallFeatureCard(
            icon: Icons.bolt_rounded,
            title: l10n.paywallFeatureFasterTitle,
            body: l10n.paywallFeatureFasterBody,
          ),
          SizedBox(width: dimens.spaceMd),
          PaywallFeatureCard(
            icon: Icons.eco_rounded,
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
      padding: EdgeInsets.fromLTRB(
        dimens.pageGutter,
        dimens.spaceXl,
        dimens.pageGutter,
        dimens.spaceXl + MediaQuery.paddingOf(context).bottom,
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
              color: colors.onPremiumMuted.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: dimens.spaceMd),
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
        color: context.appColors.onPremiumMuted.withValues(alpha: 0.7),
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
      top: MediaQuery.paddingOf(context).top + dimens.spaceSm,
      right: dimens.pageGutter,
      child: Semantics(
        button: true,
        label: l10n.paywallCloseSemantics,
        child: Material(
          color: context.appColors.premiumCanvas.withValues(alpha: 0.5),
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => context.read<PaywallBloc>().add(
              const PaywallEvent.closePressed(),
            ),
            child: Padding(
              padding: EdgeInsets.all(dimens.spaceSm),
              child: Icon(
                Icons.close_rounded,
                size: context.appDimens.iconSm,
                color: context.appColors.onPremiumMuted,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
