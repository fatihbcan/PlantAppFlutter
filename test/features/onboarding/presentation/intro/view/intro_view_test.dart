import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/intro/bloc/intro_bloc.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/intro/view/intro_view.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/intro/widgets/intro_artwork.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/intro/widgets/intro_headline.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/intro/widgets/intro_legal_text.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/intro/widgets/intro_page_dots.dart';
import 'package:hubx_flutter_case/l10n/gen/app_localizations.dart';
import 'package:hubx_flutter_case/shared/widgets/app_primary_button.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/pump_app.dart';

class _MockIntroBloc extends MockBloc<IntroEvent, IntroState>
    implements IntroBloc {}

void main() {
  late _MockIntroBloc bloc;

  setUp(() => bloc = _MockIntroBloc());

  tearDown(() => bloc.close());

  /// Pumps [IntroView] over a Bloc that starts at [initialState] and then
  /// emits [states].
  Future<void> pumpIntro(
    WidgetTester tester,
    IntroState initialState, {
    List<IntroState> states = const <IntroState>[],
  }) async {
    whenListen(
      bloc,
      Stream<IntroState>.fromIterable(states),
      initialState: initialState,
    );

    await tester.pumpApp(
      BlocProvider<IntroBloc>.value(value: bloc, child: const IntroView()),
    );
  }

  Finder headline(String text) => find.byWidgetPredicate(
    (Widget widget) => widget is IntroHeadline && widget.text == text,
  );

  Finder artwork(IntroArtwork piece) => find.byWidgetPredicate(
    (Widget widget) => widget is IntroArtworkView && widget.artwork == piece,
  );

  testWidgets('the welcome page shows its headline, artwork, consent line and '
      'no dots', (WidgetTester tester) async {
    await pumpIntro(tester, const IntroState());

    final AppL10n l10n = tester.l10n;

    expect(
      headline(l10n.onboardingWelcomeTitle(l10n.appTitle)),
      findsOneWidget,
    );
    expect(artwork(IntroArtwork.welcome), findsOneWidget);
    expect(find.byType(IntroLegalText), findsOneWidget);
    expect(find.text(l10n.onboardingWelcomeCta), findsOneWidget);
    // The design draws no dots on the first page — the run starts at page two.
    expect(find.byType(IntroPageDots), findsNothing);
  });

  testWidgets('the CTA asks the Bloc to advance', (WidgetTester tester) async {
    await pumpIntro(tester, const IntroState());

    await tester.tap(find.byType(AppPrimaryButton));

    verify(() => bloc.add(const IntroEvent.nextPressed())).called(1);
  });

  testWidgets('swiping the pages reports the new index', (
    WidgetTester tester,
  ) async {
    await pumpIntro(tester, const IntroState());

    await tester.drag(find.byType(PageView), const Offset(-400, 0));
    await tester.pumpAndSettle();

    verify(() => bloc.add(const IntroEvent.pageSwiped(1))).called(1);
  });

  testWidgets('advancing the index scrolls to that page and lights its dot', (
    WidgetTester tester,
  ) async {
    await pumpIntro(
      tester,
      const IntroState(),
      states: <IntroState>[const IntroState(pageIndex: 1)],
    );
    await tester.pumpAndSettle();

    final AppL10n l10n = tester.l10n;

    expect(headline(l10n.onboardingIdentifyTitle), findsOneWidget);
    expect(artwork(IntroArtwork.identify), findsOneWidget);
    expect(find.text(l10n.onboardingIdentifyCta), findsOneWidget);
    // The consent line belongs to the welcome page only.
    expect(find.byType(IntroLegalText), findsNothing);

    final IntroPageDots dots = tester.widget(find.byType(IntroPageDots));
    expect(dots.count, IntroBloc.pageCount);
    // Page two is the first of the three dots.
    expect(dots.activeIndex, 0);
    expect(dots.semanticsLabel, l10n.onboardingPageIndicator(2, 3));
  });

  testWidgets('the last page still routes its CTA through the Bloc', (
    WidgetTester tester,
  ) async {
    await pumpIntro(tester, const IntroState(pageIndex: 2));

    // Finishing is the Bloc's decision, not the view's: the view sends the
    // same event on every page.
    expect(find.text(tester.l10n.onboardingDiagnoseCta), findsOneWidget);

    await tester.tap(find.byType(AppPrimaryButton));

    verify(() => bloc.add(const IntroEvent.nextPressed())).called(1);
  });

  testWidgets('the layout holds on a short viewport', (
    WidgetTester tester,
  ) async {
    whenListen(
      bloc,
      const Stream<IntroState>.empty(),
      initialState: const IntroState(),
    );

    await tester.pumpApp(
      BlocProvider<IntroBloc>.value(value: bloc, child: const IntroView()),
      surfaceSize: compactSurface,
    );

    expect(tester.takeException(), isNull);
    expect(find.byType(AppPrimaryButton), findsOneWidget);
  });
}
