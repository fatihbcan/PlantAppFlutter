import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/entity/subscription_plan.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/result/onboarding_results.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/usecase/complete_onboarding.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/usecase/get_subscription_plans.dart';
import 'package:injectable/injectable.dart';

part 'paywall_bloc.freezed.dart';
part 'paywall_event.dart';
part 'paywall_state.dart';

/// Owns the paywall: plan catalogue, selection, and the one action that
/// actually ends onboarding.
///
/// Both the close button and a completed "purchase" record completion, so a
/// user who subscribes is not sent back through onboarding either. Reopened
/// later as an upsell (`completesOnboarding: false`) it skips that write and
/// only reports that the screen is done.
@injectable
class PaywallBloc extends Bloc<PaywallEvent, PaywallState> {
  PaywallBloc(this._getPlans, this._completeOnboarding)
    : super(const PaywallState()) {
    on<PaywallStarted>(_onStarted, transformer: droppable());
    on<PaywallPlanSelected>(_onPlanSelected, transformer: sequential());
    on<PaywallSubscribePressed>(_onSubscribePressed, transformer: droppable());
    on<PaywallClosePressed>(_onClosePressed, transformer: droppable());
    on<PaywallExitConsumed>(_onExitConsumed, transformer: sequential());
  }

  final GetSubscriptionPlans _getPlans;
  final CompleteOnboarding _completeOnboarding;

  Future<void> _onStarted(
    PaywallStarted event,
    Emitter<PaywallState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        error: null,
        completesOnboarding: event.completesOnboarding,
      ),
    );

    final GetPlansResult result = await _getPlans();

    switch (result) {
      case GetPlansSuccess(:final List<SubscriptionPlan> plans):
        emit(
          state.copyWith(
            isLoading: false,
            plans: plans,
            // Preselect the plan the design highlights: the discounted one,
            // falling back to the first on offer.
            selectedPlanId: state.selectedPlanId ?? _defaultPlanId(plans),
          ),
        );
      case GetPlansFailure():
        emit(
          state.copyWith(
            isLoading: false,
            error: PaywallError.plansUnavailable,
          ),
        );
    }
  }

  void _onPlanSelected(PaywallPlanSelected event, Emitter<PaywallState> emit) {
    if (event.planId == state.selectedPlanId) return;
    emit(state.copyWith(selectedPlanId: event.planId));
  }

  Future<void> _onSubscribePressed(
    PaywallSubscribePressed event,
    Emitter<PaywallState> emit,
  ) async {
    if (state.selectedPlan == null) return;

    emit(state.copyWith(isSubmitting: true, error: null));
    // There is no billing backend in this case, so "purchase" resolves
    // immediately and the only durable effect is completing onboarding.
    await _finishOnboarding(emit);
  }

  Future<void> _onClosePressed(
    PaywallClosePressed event,
    Emitter<PaywallState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true, error: null));
    await _finishOnboarding(emit);
  }

  void _onExitConsumed(PaywallExitConsumed event, Emitter<PaywallState> emit) {
    if (!state.shouldExit) return;
    emit(state.copyWith(shouldExit: false));
  }

  Future<void> _finishOnboarding(Emitter<PaywallState> emit) async {
    // Shown as an upsell, the screen has no onboarding to record — the flag
    // was already written the first time through the flow.
    if (!state.completesOnboarding) {
      emit(state.copyWith(isSubmitting: false, shouldExit: true));
      return;
    }

    final CompleteOnboardingResult result = await _completeOnboarding();

    switch (result) {
      case CompleteOnboardingSuccess():
        emit(state.copyWith(isSubmitting: false, shouldExit: true));
      case CompleteOnboardingFailure():
        // The flag could not be persisted. Let the user through anyway —
        // trapping them in onboarding is the worse failure — but surface it.
        emit(
          state.copyWith(
            isSubmitting: false,
            shouldExit: true,
            error: PaywallError.completionFailed,
          ),
        );
    }
  }

  String? _defaultPlanId(List<SubscriptionPlan> plans) {
    if (plans.isEmpty) return null;
    for (final SubscriptionPlan plan in plans) {
      if (plan.hasDiscount) return plan.id;
    }
    return plans.first.id;
  }
}
