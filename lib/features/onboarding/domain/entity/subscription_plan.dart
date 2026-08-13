import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_plan.freezed.dart';

/// How often a [SubscriptionPlan] renews.
enum BillingPeriod { monthly, yearly }

/// A purchasable plan offered on the paywall.
///
/// Prices arrive pre-formatted for the store locale — the domain never does
/// currency formatting, and the UI never does arithmetic on money.
@freezed
abstract class SubscriptionPlan with _$SubscriptionPlan {
  const factory SubscriptionPlan({
    required String id,
    required BillingPeriod period,
    required String formattedPrice,
    @Default(0) int trialDays,
    @Default(0) int discountPercent,
  }) = _SubscriptionPlan;

  const SubscriptionPlan._();

  /// Whether to show the "save X%" badge.
  bool get hasDiscount => discountPercent > 0;

  /// Whether the CTA should promise a free trial.
  bool get hasTrial => trialDays > 0;
}
