import 'package:hubx_flutter_case/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/result/onboarding_results.dart';
import 'package:injectable/injectable.dart';

/// Reads whether onboarding has already been completed on this device.
///
/// The router guard calls this on every navigation to the onboarding branch.
@injectable
class GetOnboardingStatus {
  const GetOnboardingStatus(this._repository);

  final OnboardingRepository _repository;

  Future<OnboardingStatusResult> call() => _repository.readStatus();
}
