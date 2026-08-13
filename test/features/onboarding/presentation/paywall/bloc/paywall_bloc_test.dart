import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/entity/subscription_plan.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/result/onboarding_results.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/usecase/complete_onboarding.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/usecase/get_subscription_plans.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/paywall/bloc/paywall_bloc.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetPlans extends Mock implements GetSubscriptionPlans {}

class _MockCompleteOnboarding extends Mock implements CompleteOnboarding {}

void main() {
  late _MockGetPlans getPlans;
  late _MockCompleteOnboarding completeOnboarding;

  const SubscriptionPlan monthly = SubscriptionPlan(
    id: 'monthly',
    period: BillingPeriod.monthly,
    formattedPrice: r'$2.99',
  );
  const SubscriptionPlan yearly = SubscriptionPlan(
    id: 'yearly',
    period: BillingPeriod.yearly,
    formattedPrice: r'$529.99',
    trialDays: 3,
    discountPercent: 50,
  );
  const List<SubscriptionPlan> plans = <SubscriptionPlan>[monthly, yearly];

  setUp(() {
    getPlans = _MockGetPlans();
    completeOnboarding = _MockCompleteOnboarding();
  });

  PaywallBloc build() => PaywallBloc(getPlans, completeOnboarding);

  void stubPlans() {
    when(() => getPlans())
        .thenAnswer((_) async => const GetPlansResult.success(plans));
  }

  void stubCompletionSuccess() {
    when(() => completeOnboarding())
        .thenAnswer((_) async => const CompleteOnboardingResult.success());
  }

  group('started', () {
    blocTest<PaywallBloc, PaywallState>(
      'loads plans and preselects the discounted one',
      setUp: stubPlans,
      build: build,
      act: (PaywallBloc bloc) => bloc.add(const PaywallEvent.started()),
      expect: () => <PaywallState>[
        const PaywallState(isLoading: true),
        const PaywallState(plans: plans, selectedPlanId: 'yearly'),
      ],
    );

    blocTest<PaywallBloc, PaywallState>(
      'falls back to the first plan when none is discounted',
      setUp: () {
        when(() => getPlans()).thenAnswer(
          (_) async =>
              const GetPlansResult.success(<SubscriptionPlan>[monthly]),
        );
      },
      build: build,
      act: (PaywallBloc bloc) => bloc.add(const PaywallEvent.started()),
      verify: (PaywallBloc bloc) =>
          expect(bloc.state.selectedPlanId, 'monthly'),
    );

    blocTest<PaywallBloc, PaywallState>(
      'surfaces a load failure',
      setUp: () {
        when(() => getPlans())
            .thenAnswer((_) async => const GetPlansResult.failure());
      },
      build: build,
      act: (PaywallBloc bloc) => bloc.add(const PaywallEvent.started()),
      expect: () => <PaywallState>[
        const PaywallState(isLoading: true),
        const PaywallState(error: PaywallError.plansUnavailable),
      ],
    );

    blocTest<PaywallBloc, PaywallState>(
      'keeps a user selection across a retry',
      setUp: stubPlans,
      build: build,
      seed: () => const PaywallState(selectedPlanId: 'monthly'),
      act: (PaywallBloc bloc) => bloc.add(const PaywallEvent.started()),
      verify: (PaywallBloc bloc) =>
          expect(bloc.state.selectedPlanId, 'monthly'),
    );
  });

  group('planSelected', () {
    blocTest<PaywallBloc, PaywallState>(
      'changes the selection',
      build: build,
      seed: () => const PaywallState(plans: plans, selectedPlanId: 'yearly'),
      act: (PaywallBloc bloc) =>
          bloc.add(const PaywallEvent.planSelected('monthly')),
      expect: () => <PaywallState>[
        const PaywallState(plans: plans, selectedPlanId: 'monthly'),
      ],
    );

    blocTest<PaywallBloc, PaywallState>(
      'ignores a tap on the already selected plan',
      build: build,
      seed: () => const PaywallState(plans: plans, selectedPlanId: 'yearly'),
      act: (PaywallBloc bloc) =>
          bloc.add(const PaywallEvent.planSelected('yearly')),
      expect: () => <PaywallState>[],
    );
  });

  group('closePressed', () {
    blocTest<PaywallBloc, PaywallState>(
      'records completion and asks the view to leave',
      setUp: stubCompletionSuccess,
      build: build,
      act: (PaywallBloc bloc) => bloc.add(const PaywallEvent.closePressed()),
      expect: () => <PaywallState>[
        const PaywallState(isSubmitting: true),
        const PaywallState(shouldExit: true),
      ],
      verify: (_) => verify(() => completeOnboarding()).called(1),
    );

    blocTest<PaywallBloc, PaywallState>(
      'still lets the user out when the flag cannot be persisted',
      setUp: () {
        when(() => completeOnboarding())
            .thenAnswer((_) async => const CompleteOnboardingResult.failure());
      },
      build: build,
      act: (PaywallBloc bloc) => bloc.add(const PaywallEvent.closePressed()),
      verify: (PaywallBloc bloc) {
        expect(bloc.state.shouldExit, isTrue);
        expect(bloc.state.error, PaywallError.completionFailed);
      },
    );

    blocTest<PaywallBloc, PaywallState>(
      'drops a second close while the first is in flight',
      setUp: () {
        when(() => completeOnboarding()).thenAnswer(
          (_) => Future<CompleteOnboardingResult>.delayed(
            const Duration(milliseconds: 50),
            () => const CompleteOnboardingResult.success(),
          ),
        );
      },
      build: build,
      act: (PaywallBloc bloc) => bloc
        ..add(const PaywallEvent.closePressed())
        ..add(const PaywallEvent.closePressed()),
      wait: const Duration(milliseconds: 120),
      verify: (_) => verify(() => completeOnboarding()).called(1),
    );
  });

  group('subscribePressed', () {
    blocTest<PaywallBloc, PaywallState>(
      'completes onboarding for a subscribing user too',
      setUp: stubCompletionSuccess,
      build: build,
      seed: () => const PaywallState(plans: plans, selectedPlanId: 'yearly'),
      act: (PaywallBloc bloc) =>
          bloc.add(const PaywallEvent.subscribePressed()),
      verify: (PaywallBloc bloc) {
        verify(() => completeOnboarding()).called(1);
        expect(bloc.state.shouldExit, isTrue);
      },
    );

    blocTest<PaywallBloc, PaywallState>(
      'does nothing without a selected plan',
      build: build,
      act: (PaywallBloc bloc) =>
          bloc.add(const PaywallEvent.subscribePressed()),
      expect: () => <PaywallState>[],
      verify: (_) => verifyNever(() => completeOnboarding()),
    );
  });

  group('exitConsumed', () {
    blocTest<PaywallBloc, PaywallState>(
      'clears the exit flag so returning does not re-navigate',
      build: build,
      seed: () => const PaywallState(shouldExit: true),
      act: (PaywallBloc bloc) => bloc.add(const PaywallEvent.exitConsumed()),
      expect: () => <PaywallState>[const PaywallState()],
    );

    blocTest<PaywallBloc, PaywallState>(
      'is a no-op when the flag is already clear',
      build: build,
      act: (PaywallBloc bloc) => bloc.add(const PaywallEvent.exitConsumed()),
      expect: () => <PaywallState>[],
    );
  });

  group('state getters', () {
    test('selectedPlan resolves the id against the catalogue', () {
      const PaywallState state = PaywallState(
        plans: plans,
        selectedPlanId: 'yearly',
      );

      expect(state.selectedPlan, yearly);
      expect(state.offersTrial, isTrue);
      expect(state.canSubmit, isTrue);
    });

    test('selectedPlan is null for an unknown id', () {
      const PaywallState state = PaywallState(
        plans: plans,
        selectedPlanId: 'gone',
      );

      expect(state.selectedPlan, isNull);
      expect(state.canSubmit, isFalse);
    });

    test('canSubmit is false while a submission is in flight', () {
      const PaywallState state = PaywallState(
        plans: plans,
        selectedPlanId: 'yearly',
        isSubmitting: true,
      );

      expect(state.canSubmit, isFalse);
    });

    test('isInitialLoading only while the catalogue is empty', () {
      expect(const PaywallState(isLoading: true).isInitialLoading, isTrue);
      expect(
        const PaywallState(isLoading: true, plans: plans).isInitialLoading,
        isFalse,
      );
    });
  });
}
