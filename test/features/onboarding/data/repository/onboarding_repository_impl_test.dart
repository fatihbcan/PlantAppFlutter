import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/features/onboarding/data/datasource/onboarding_local_data_source.dart';
import 'package:hubx_flutter_case/features/onboarding/data/dto/subscription_plan_dto.dart';
import 'package:hubx_flutter_case/features/onboarding/data/repository/onboarding_repository_impl.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/entity/subscription_plan.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/result/onboarding_results.dart';
import 'package:mocktail/mocktail.dart';

class _MockLocal extends Mock implements OnboardingLocalDataSource {}

void main() {
  late _MockLocal local;
  late OnboardingRepositoryImpl repository;

  setUp(() {
    local = _MockLocal();
    repository = OnboardingRepositoryImpl(local);
  });

  group('readStatus', () {
    test('returns completed when the flag is set', () async {
      when(() => local.readCompleted()).thenAnswer((_) async => true);

      expect(await repository.readStatus(), isA<OnboardingStatusCompleted>());
    });

    test('returns pending when the flag is unset', () async {
      when(() => local.readCompleted()).thenAnswer((_) async => false);

      expect(await repository.readStatus(), isA<OnboardingStatusPending>());
    });

    test('returns unavailable when the store throws', () async {
      when(() => local.readCompleted()).thenThrow(StateError('disk'));

      expect(await repository.readStatus(), isA<OnboardingStatusUnavailable>());
    });
  });

  group('markCompleted', () {
    test('returns success once the write lands', () async {
      when(() => local.writeCompleted()).thenAnswer((_) async {});

      expect(
        await repository.markCompleted(),
        isA<CompleteOnboardingSuccess>(),
      );
      verify(() => local.writeCompleted()).called(1);
    });

    test('returns failure when the write throws', () async {
      when(() => local.writeCompleted()).thenThrow(StateError('disk full'));

      expect(
        await repository.markCompleted(),
        isA<CompleteOnboardingFailure>(),
      );
    });
  });

  group('getPlans', () {
    test('maps DTOs onto entities', () async {
      when(() => local.readPlans()).thenAnswer(
        (_) async => const <SubscriptionPlanDto>[
          SubscriptionPlanDto(
            id: 'yearly',
            period: 'yearly',
            formattedPrice: r'$529.99',
            trialDays: 3,
            discountPercent: 50,
          ),
        ],
      );

      final GetPlansResult result = await repository.getPlans();

      expect(result, isA<GetPlansSuccess>());
      final SubscriptionPlan plan = (result as GetPlansSuccess).plans.single;
      expect(plan.period, BillingPeriod.yearly);
      expect(plan.hasTrial, isTrue);
      expect(plan.hasDiscount, isTrue);
    });

    test('returns failure when the source throws', () async {
      when(() => local.readPlans()).thenThrow(StateError('boom'));

      expect(await repository.getPlans(), isA<GetPlansFailure>());
    });
  });
}
