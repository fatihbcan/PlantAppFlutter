import 'package:hubx_flutter_case/features/onboarding/domain/result/onboarding_results.dart';

/// Persistence and content for the onboarding flow.
///
/// Implemented in `data/`. Nothing here knows about SharedPreferences, and no
/// implementation may throw across this boundary — failures come back as a
/// case of the operation's result union.
abstract interface class OnboardingRepository {
  /// Whether the user already finished onboarding on this device.
  Future<OnboardingStatusResult> readStatus();

  /// Records that onboarding is finished. Idempotent.
  Future<CompleteOnboardingResult> markCompleted();

  /// The plans shown on the paywall.
  Future<GetPlansResult> getPlans();
}
