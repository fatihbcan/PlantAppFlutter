import 'package:hubx_flutter_case/features/onboarding/data/dto/subscription_plan_dto.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/entity/subscription_plan.dart';

/// DTO → entity, at the repository boundary.
extension SubscriptionPlanDtoMapper on SubscriptionPlanDto {
  SubscriptionPlan toEntity() => SubscriptionPlan(
    id: id,
    period: _periodFrom(period),
    formattedPrice: formattedPrice,
    trialDays: trialDays,
    discountPercent: discountPercent,
  );

  /// Unknown periods fall back to monthly rather than throwing: a new plan
  /// type added server-side should not blank the paywall.
  BillingPeriod _periodFrom(String raw) => switch (raw.toLowerCase()) {
    'yearly' || 'annual' => BillingPeriod.yearly,
    _ => BillingPeriod.monthly,
  };
}
