import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/features/onboarding/data/dto/subscription_plan_dto.dart';
import 'package:hubx_flutter_case/features/onboarding/data/mapper/subscription_plan_mapper.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/entity/subscription_plan.dart';

void main() {
  group('SubscriptionPlanDtoMapper', () {
    test('maps a monthly plan', () {
      const SubscriptionPlanDto dto = SubscriptionPlanDto(
        id: 'monthly',
        period: 'monthly',
        formattedPrice: r'$2.99',
      );

      final SubscriptionPlan plan = dto.toEntity();

      expect(plan.period, BillingPeriod.monthly);
      expect(plan.formattedPrice, r'$2.99');
      expect(plan.hasTrial, isFalse);
      expect(plan.hasDiscount, isFalse);
    });

    test('accepts "annual" as a synonym for yearly', () {
      const SubscriptionPlanDto dto = SubscriptionPlanDto(
        id: 'y',
        period: 'ANNUAL',
        formattedPrice: r'$99',
      );

      expect(dto.toEntity().period, BillingPeriod.yearly);
    });

    test('falls back to monthly on an unknown period rather than throwing', () {
      const SubscriptionPlanDto dto = SubscriptionPlanDto(
        id: 'weird',
        period: 'fortnightly',
        formattedPrice: r'$1',
      );

      expect(dto.toEntity().period, BillingPeriod.monthly);
    });

    test('round-trips through JSON', () {
      const SubscriptionPlanDto dto = SubscriptionPlanDto(
        id: 'yearly',
        period: 'yearly',
        formattedPrice: r'$529.99',
        trialDays: 3,
        discountPercent: 50,
      );

      final SubscriptionPlanDto decoded = SubscriptionPlanDto.fromJson(
        dto.toJson(),
      );

      expect(decoded.trialDays, 3);
      expect(decoded.discountPercent, 50);
      expect(decoded.toEntity(), dto.toEntity());
    });
  });
}
