import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/result/onboarding_results.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/usecase/complete_onboarding.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/usecase/get_onboarding_status.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/usecase/get_subscription_plans.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepository extends Mock implements OnboardingRepository {}

void main() {
  late _MockRepository repository;

  setUp(() => repository = _MockRepository());

  group('GetOnboardingStatus', () {
    test('passes the completed case through untouched', () async {
      when(() => repository.readStatus())
          .thenAnswer((_) async => const OnboardingStatusResult.completed());

      expect(
        await GetOnboardingStatus(repository)(),
        isA<OnboardingStatusCompleted>(),
      );
    });

    test('passes the pending case through untouched', () async {
      when(() => repository.readStatus())
          .thenAnswer((_) async => const OnboardingStatusResult.pending());

      expect(
        await GetOnboardingStatus(repository)(),
        isA<OnboardingStatusPending>(),
      );
    });

    test('passes the unavailable case through untouched', () async {
      when(() => repository.readStatus())
          .thenAnswer((_) async => const OnboardingStatusResult.unavailable());

      expect(
        await GetOnboardingStatus(repository)(),
        isA<OnboardingStatusUnavailable>(),
      );
    });
  });

  group('CompleteOnboarding', () {
    test('returns success', () async {
      when(() => repository.markCompleted())
          .thenAnswer((_) async => const CompleteOnboardingResult.success());

      expect(
        await CompleteOnboarding(repository)(),
        isA<CompleteOnboardingSuccess>(),
      );
    });

    test('returns failure', () async {
      when(() => repository.markCompleted())
          .thenAnswer((_) async => const CompleteOnboardingResult.failure());

      expect(
        await CompleteOnboarding(repository)(),
        isA<CompleteOnboardingFailure>(),
      );
    });
  });

  group('GetSubscriptionPlans', () {
    test('returns the catalogue', () async {
      when(() => repository.getPlans())
          .thenAnswer((_) async => const GetPlansResult.success([]));

      expect(await GetSubscriptionPlans(repository)(), isA<GetPlansSuccess>());
    });

    test('returns failure', () async {
      when(() => repository.getPlans())
          .thenAnswer((_) async => const GetPlansResult.failure());

      expect(await GetSubscriptionPlans(repository)(), isA<GetPlansFailure>());
    });
  });
}
