import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/core/storage/key_value_store.dart';
import 'package:hubx_flutter_case/features/onboarding/data/datasource/onboarding_local_data_source.dart';
import 'package:hubx_flutter_case/features/onboarding/data/dto/subscription_plan_dto.dart';
import 'package:mocktail/mocktail.dart';

class _MockStore extends Mock implements KeyValueStore {}

void main() {
  late _MockStore store;
  late OnboardingLocalDataSourceImpl dataSource;

  setUp(() {
    store = _MockStore();
    dataSource = OnboardingLocalDataSourceImpl(store);
  });

  group('readCompleted', () {
    test('defaults to false when the key was never written', () async {
      when(() => store.readBool(OnboardingLocalDataSourceImpl.completedKey))
          .thenAnswer((_) async => null);

      expect(await dataSource.readCompleted(), isFalse);
    });

    test('returns the stored value', () async {
      when(() => store.readBool(OnboardingLocalDataSourceImpl.completedKey))
          .thenAnswer((_) async => true);

      expect(await dataSource.readCompleted(), isTrue);
    });
  });

  group('writeCompleted', () {
    test('writes true under the completion key', () async {
      when(() => store.writeBool(any(), value: any(named: 'value')))
          .thenAnswer((_) async {});

      await dataSource.writeCompleted();

      verify(
        () => store.writeBool(
          OnboardingLocalDataSourceImpl.completedKey,
          value: true,
        ),
      ).called(1);
    });
  });

  group('readPlans', () {
    test('offers a monthly and a discounted yearly plan', () async {
      final List<SubscriptionPlanDto> plans = await dataSource.readPlans();

      expect(plans, hasLength(2));
      expect(plans.map((SubscriptionPlanDto p) => p.period), <String>[
        'monthly',
        'yearly',
      ]);
      expect(plans.last.trialDays, 3);
      expect(plans.last.discountPercent, 50);
    });
  });
}
