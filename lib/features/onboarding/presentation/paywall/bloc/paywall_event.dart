part of 'paywall_bloc.dart';

@freezed
sealed class PaywallEvent with _$PaywallEvent {
  /// The screen was opened, or the user retried after a load failure.
  const factory PaywallEvent.started() = PaywallStarted;

  /// The user tapped the plan tile with [planId].
  const factory PaywallEvent.planSelected(String planId) = PaywallPlanSelected;

  /// The user tapped the subscribe CTA.
  const factory PaywallEvent.subscribePressed() = PaywallSubscribePressed;

  /// The user tapped the close button, which is what ends onboarding.
  const factory PaywallEvent.closePressed() = PaywallClosePressed;

  /// The view has navigated away and the exit flag can be cleared.
  const factory PaywallEvent.exitConsumed() = PaywallExitConsumed;
}
