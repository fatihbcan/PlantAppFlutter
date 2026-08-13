import 'package:hubx_flutter_case/features/onboarding/data/datasource/onboarding_local_data_source.dart';
import 'package:hubx_flutter_case/features/onboarding/data/dto/subscription_plan_dto.dart';
import 'package:hubx_flutter_case/features/onboarding/data/mapper/subscription_plan_mapper.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/entity/subscription_plan.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/result/onboarding_results.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._local);

  final OnboardingLocalDataSource _local;

  @override
  Future<OnboardingStatusResult> readStatus() async {
    try {
      final bool completed = await _local.readCompleted();
      return completed
          ? const OnboardingStatusResult.completed()
          : const OnboardingStatusResult.pending();
    } on Object catch (error) {
      return OnboardingStatusResult.unavailable(error);
    }
  }

  @override
  Future<CompleteOnboardingResult> markCompleted() async {
    try {
      await _local.writeCompleted();
      return const CompleteOnboardingResult.success();
    } on Object catch (error) {
      return CompleteOnboardingResult.failure(error);
    }
  }

  @override
  Future<GetPlansResult> getPlans() async {
    try {
      final List<SubscriptionPlanDto> dtos = await _local.readPlans();
      final List<SubscriptionPlan> plans = dtos
          .map((SubscriptionPlanDto dto) => dto.toEntity())
          .toList(growable: false);
      return GetPlansResult.success(plans);
    } on Object catch (error) {
      return GetPlansResult.failure(error);
    }
  }
}
