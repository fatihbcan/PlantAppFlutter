part of 'paywall_bloc.dart';

@freezed
abstract class PaywallState with _$PaywallState {
  const factory PaywallState({
    @Default(false) bool isLoading,
    @Default(<SubscriptionPlan>[]) List<SubscriptionPlan> plans,
    @Default(null) String? selectedPlanId,
    @Default(false) bool isSubmitting,
    @Default(null) PaywallError? error,

    /// Set once onboarding is recorded as complete and the flow should leave
    /// for home. Cleared by [PaywallExitConsumed].
    @Default(false) bool shouldExit,
  }) = _PaywallState;

  const PaywallState._();

  /// The plan the CTA would purchase, or null while plans are loading.
  SubscriptionPlan? get selectedPlan {
    for (final SubscriptionPlan plan in plans) {
      if (plan.id == selectedPlanId) return plan;
    }
    return null;
  }

  bool get hasPlans => plans.isNotEmpty;

  /// True only while there is nothing at all to render.
  bool get isInitialLoading => isLoading && !hasPlans;

  /// The CTA is live once a plan is selected and nothing is in flight.
  bool get canSubmit => selectedPlan != null && !isSubmitting;

  /// Whether the CTA should promise a free trial rather than a purchase.
  bool get offersTrial => selectedPlan?.hasTrial ?? false;
}

/// Why the paywall could not do what was asked, as a UI-facing category.
///
/// The Bloc maps result-union cases onto this so the view never switches on
/// a domain type.
enum PaywallError { plansUnavailable, completionFailed }
