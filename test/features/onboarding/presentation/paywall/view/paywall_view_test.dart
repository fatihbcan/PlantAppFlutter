import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/features/onboarding/domain/entity/subscription_plan.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/paywall/bloc/paywall_bloc.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/paywall/view/paywall_view.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/paywall/widgets/paywall_feature_card.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/paywall/widgets/paywall_plan_tile.dart';
import 'package:hubx_flutter_case/l10n/gen/app_localizations.dart';
import 'package:hubx_flutter_case/shared/widgets/app_error_view.dart';
import 'package:hubx_flutter_case/shared/widgets/app_loader.dart';
import 'package:hubx_flutter_case/shared/widgets/app_primary_button.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/pump_app.dart';

class _MockPaywallBloc extends MockBloc<PaywallEvent, PaywallState>
    implements PaywallBloc {}

void main() {
  late _MockPaywallBloc bloc;

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
  const PaywallState loaded = PaywallState(
    plans: plans,
    selectedPlanId: 'yearly',
  );

  setUp(() => bloc = _MockPaywallBloc());

  tearDown(() => bloc.close());

  Future<void> pumpPaywall(WidgetTester tester, PaywallState state) async {
    whenListen(bloc, const Stream<PaywallState>.empty(), initialState: state);

    await tester.pumpApp(
      BlocProvider<PaywallBloc>.value(value: bloc, child: const PaywallView()),
      surfaceSize: tallSurface,
    );
  }

  Finder planTile({required bool isSelected}) => find.byWidgetPredicate(
    (Widget widget) =>
        widget is PaywallPlanTile && widget.isSelected == isSelected,
  );

  testWidgets('an empty catalogue shows the loader', (
    WidgetTester tester,
  ) async {
    await pumpPaywall(tester, const PaywallState(isLoading: true));

    expect(find.byType(AppLoader), findsOneWidget);
    expect(find.byType(PaywallPlanTile), findsNothing);
  });

  testWidgets('renders the hero, the feature strip and a tile per plan', (
    WidgetTester tester,
  ) async {
    await pumpPaywall(tester, loaded);

    final AppL10n l10n = tester.l10n;

    expect(find.byType(PaywallFeatureCard), findsNWidgets(3));
    expect(find.byType(PaywallPlanTile), findsNWidgets(plans.length));
    expect(find.text(l10n.paywallPlanMonthlyTitle), findsOneWidget);
    expect(find.text(l10n.paywallPlanYearlyTitle), findsOneWidget);
    // The badge hangs off the discounted plan only.
    expect(find.text(l10n.paywallPlanBadge), findsOneWidget);
  });

  testWidgets('exactly one tile is marked selected', (
    WidgetTester tester,
  ) async {
    await pumpPaywall(tester, loaded);

    expect(planTile(isSelected: true), findsOneWidget);
    expect(planTile(isSelected: false), findsOneWidget);
    expect(
      find.descendant(
        of: planTile(isSelected: true),
        matching: find.text(tester.l10n.paywallPlanYearlyTitle),
      ),
      findsOneWidget,
    );
  });

  testWidgets('tapping the other tile selects it', (WidgetTester tester) async {
    await pumpPaywall(tester, loaded);

    await tester.tap(planTile(isSelected: false));

    verify(() => bloc.add(const PaywallEvent.planSelected('monthly')))
        .called(1);
  });

  testWidgets('the CTA subscribes to the selected plan', (
    WidgetTester tester,
  ) async {
    await pumpPaywall(tester, loaded);

    await tester.tap(find.byType(AppPrimaryButton));

    verify(() => bloc.add(const PaywallEvent.subscribePressed())).called(1);
  });

  testWidgets('the CTA is inert while a submission is in flight', (
    WidgetTester tester,
  ) async {
    await pumpPaywall(tester, loaded.copyWith(isSubmitting: true));

    final AppPrimaryButton button = tester.widget(
      find.byType(AppPrimaryButton),
    );
    expect(button.isLoading, isTrue);
    expect(button.onPressed, isNull);

    await tester.tap(find.byType(AppPrimaryButton));

    verifyNever(() => bloc.add(const PaywallEvent.subscribePressed()));
  });

  testWidgets('the close control ends onboarding', (WidgetTester tester) async {
    await pumpPaywall(tester, loaded);

    await tester.tap(find.bySemanticsLabel(tester.l10n.paywallCloseSemantics));

    verify(() => bloc.add(const PaywallEvent.closePressed())).called(1);
  });

  testWidgets('an unavailable catalogue offers a retry', (
    WidgetTester tester,
  ) async {
    await pumpPaywall(
      tester,
      const PaywallState(error: PaywallError.plansUnavailable),
    );

    expect(find.byType(AppErrorView), findsOneWidget);
    expect(find.byType(PaywallPlanTile), findsNothing);

    await tester.tap(find.byType(TextButton));

    verify(() => bloc.add(const PaywallEvent.started())).called(1);
  });

  testWidgets('a completion that could not be persisted does not block the '
      'screen', (WidgetTester tester) async {
    // The Bloc lets the user out anyway; the view carries on rendering the
    // paywall rather than replacing it with an error. Announcing the failure
    // is PaywallPage's job — it owns the ScaffoldMessenger and the router —
    // so it is out of this seam.
    await pumpPaywall(
      tester,
      loaded.copyWith(shouldExit: true, error: PaywallError.completionFailed),
    );

    expect(find.byType(AppErrorView), findsNothing);
    expect(find.byType(PaywallPlanTile), findsNWidgets(plans.length));
    expect(find.byType(AppPrimaryButton), findsOneWidget);
  });

  testWidgets('the layout holds on a short viewport', (
    WidgetTester tester,
  ) async {
    whenListen(bloc, const Stream<PaywallState>.empty(), initialState: loaded);

    await tester.pumpApp(
      BlocProvider<PaywallBloc>.value(value: bloc, child: const PaywallView()),
      surfaceSize: compactSurface,
    );

    expect(tester.takeException(), isNull);
    expect(find.byType(PaywallPlanTile), findsWidgets);
  });
}
