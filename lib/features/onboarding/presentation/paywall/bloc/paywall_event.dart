part of 'paywall_bloc.dart';

@freezed
sealed class PaywallEvent with _$PaywallEvent {
  /// The screen was opened, or the user retried after a load failure.
  ///
  /// [completesOnboarding] is false when the paywall is shown as an upsell
  /// from a screen the user already reached, so leaving it is a plain exit
  /// rather than the end of the onboarding flow.
  const factory PaywallEvent.started({
    @Default(true) bool completesOnboarding,
  }) = PaywallStarted;

  /// The user tapped the plan tile with [planId].
  const factory PaywallEvent.planSelected(String planId) = PaywallPlanSelected;

  /// The user tapped the subscribe CTA.
  const factory PaywallEvent.subscribePressed() = PaywallSubscribePressed;

  /// The user tapped the close button, which ends onboarding when the screen
  /// is the last step of it.
  const factory PaywallEvent.closePressed() = PaywallClosePressed;

  /// The view has navigated away and the exit flag can be cleared.
  const factory PaywallEvent.exitConsumed() = PaywallExitConsumed;
}
