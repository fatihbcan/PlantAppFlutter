import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/entity/subscription_plan.dart';

part 'onboarding_results.freezed.dart';

/// Outcome of reading the onboarding-completed flag.
///
/// A read failure is deliberately *not* fatal: the caller treats it as "not
/// completed" and shows onboarding, which is the safe direction to fail in.
@freezed
sealed class OnboardingStatusResult with _$OnboardingStatusResult {
  const factory OnboardingStatusResult.completed() = OnboardingStatusCompleted;
  const factory OnboardingStatusResult.pending() = OnboardingStatusPending;
  const factory OnboardingStatusResult.unavailable([Object? cause]) =
      OnboardingStatusUnavailable;
}

/// Outcome of marking onboarding finished.
@freezed
sealed class CompleteOnboardingResult with _$CompleteOnboardingResult {
  const factory CompleteOnboardingResult.success() = CompleteOnboardingSuccess;
  const factory CompleteOnboardingResult.failure([Object? cause]) =
      CompleteOnboardingFailure;
}

/// Outcome of loading the paywall's plan catalogue.
@freezed
sealed class GetPlansResult with _$GetPlansResult {
  const factory GetPlansResult.success(List<SubscriptionPlan> plans) =
      GetPlansSuccess;
  const factory GetPlansResult.failure([Object? cause]) = GetPlansFailure;
}
