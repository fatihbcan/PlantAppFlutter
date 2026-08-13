import 'package:hubx_flutter_case/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/result/onboarding_results.dart';
import 'package:injectable/injectable.dart';

/// Marks the onboarding flow finished, so the guard stops routing here.
///
/// Called when the paywall's close button is tapped — the case defines that
/// tap, not the purchase, as the end of onboarding.
@injectable
class CompleteOnboarding {
  const CompleteOnboarding(this._repository);

  final OnboardingRepository _repository;

  Future<CompleteOnboardingResult> call() => _repository.markCompleted();
}
