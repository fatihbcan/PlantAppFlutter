import 'package:hubx_flutter_case/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/result/onboarding_results.dart';
import 'package:injectable/injectable.dart';

/// Loads the plans offered on the paywall.
@injectable
class GetSubscriptionPlans {
  const GetSubscriptionPlans(this._repository);

  final OnboardingRepository _repository;

  Future<GetPlansResult> call() => _repository.getPlans();
}
