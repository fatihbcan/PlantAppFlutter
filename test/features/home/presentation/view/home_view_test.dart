import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/features/home/domain/entity/category.dart';
import 'package:hubx_flutter_case/features/home/domain/entity/question.dart';
import 'package:hubx_flutter_case/features/home/presentation/bloc/home_bloc.dart';
import 'package:hubx_flutter_case/features/home/presentation/view/home_view.dart';
import 'package:hubx_flutter_case/features/home/presentation/widgets/category_tile.dart';
import 'package:hubx_flutter_case/features/home/presentation/widgets/home_premium_banner.dart';
import 'package:hubx_flutter_case/features/home/presentation/widgets/question_card.dart';
import 'package:hubx_flutter_case/shared/widgets/app_error_view.dart';
import 'package:hubx_flutter_case/shared/widgets/app_loader.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/pump_app.dart';

class _MockHomeBloc extends MockBloc<HomeEvent, HomeState>
    implements HomeBloc {}

void main() {
  late _MockHomeBloc bloc;

  const List<Category> categories = <Category>[
    Category(id: 1, title: 'Ferns', imageUrl: 'https://example.com/a.png'),
    Category(id: 2, title: 'Cacti', imageUrl: 'https://example.com/b.png'),
    Category(id: 3, title: 'Palms', imageUrl: 'https://example.com/c.png'),
  ];
  const List<Question> questions = <Question>[
    Question(
      id: 1,
      title: 'How to identify plants?',
      subtitle: 'Life Style',
      imageUrl: 'https://example.com/d.png',
      articleUrl: 'https://example.com/1',
    ),
    Question(
      id: 2,
      title: 'Why are my leaves yellow?',
      subtitle: 'Care',
      imageUrl: 'https://example.com/e.png',
      articleUrl: 'https://example.com/2',
    ),
  ];

  setUp(() => bloc = _MockHomeBloc());

  tearDown(() => bloc.close());

  /// Pumps [HomeView] with [state] as the Bloc's only state.
  ///
  /// The View is the widget-test seam: it reads its Bloc off the context, so
  /// a mocked one is all it needs. HomePage is out of scope — it exists to
  /// wire up DI and the router.
  Future<void> pumpHome(
    WidgetTester tester,
    HomeState state, {
    Size surfaceSize = tallSurface,
    VoidCallback? onPremiumTap,
  }) async {
    whenListen(bloc, const Stream<HomeState>.empty(), initialState: state);

    await tester.pumpApp(
      BlocProvider<HomeBloc>.value(
        value: bloc,
        child: HomeView(onPremiumTap: onPremiumTap ?? () {}),
      ),
      surfaceSize: surfaceSize,
    );
  }

  /// The section error is the compact variant; the page-level one is not.
  Finder errorView({required bool isCompact}) => find.byWidgetPredicate(
    (Widget widget) => widget is AppErrorView && widget.isCompact == isCompact,
  );

  testWidgets('the first load shows the loader and nothing else', (
    WidgetTester tester,
  ) async {
    await pumpHome(tester, const HomeState(isLoading: true));

    expect(find.byType(AppLoader), findsOneWidget);
    expect(find.byType(QuestionCard), findsNothing);
    expect(find.byType(CategoryTile), findsNothing);
    expect(find.byType(AppErrorView), findsNothing);
  });

  testWidgets('a loaded state renders a card per question and a tile per '
      'category', (WidgetTester tester) async {
    await pumpHome(
      tester,
      const HomeState(questions: questions, categories: categories),
    );

    expect(find.byType(AppLoader), findsNothing);
    expect(find.byType(QuestionCard), findsNWidgets(questions.length));
    expect(find.byType(CategoryTile), findsNWidgets(categories.length));
  });

  testWidgets('a refresh over existing content keeps the content on screen', (
    WidgetTester tester,
  ) async {
    await pumpHome(
      tester,
      const HomeState(
        isLoading: true,
        questions: questions,
        categories: categories,
      ),
    );

    expect(find.byType(AppLoader), findsNothing);
    expect(find.byType(CategoryTile), findsNWidgets(categories.length));
  });

  group('failures', () {
    testWidgets('a failed questions load shows the compact error and retries '
        'from it', (WidgetTester tester) async {
      await pumpHome(
        tester,
        const HomeState(
          categories: categories,
          questionsFailure: HomeFailure.network,
        ),
      );

      expect(errorView(isCompact: true), findsOneWidget);
      expect(find.byType(QuestionCard), findsNothing);
      // The categories are untouched by the articles failing.
      expect(find.byType(CategoryTile), findsNWidgets(categories.length));

      await tester.tap(
        find.descendant(
          of: errorView(isCompact: true),
          matching: find.byType(TextButton),
        ),
      );

      verify(() => bloc.add(const HomeEvent.refreshRequested())).called(1);
    });

    testWidgets('a failed categories load leaves the carousel usable', (
      WidgetTester tester,
    ) async {
      await pumpHome(
        tester,
        const HomeState(
          questions: questions,
          categoriesFailure: HomeFailure.server,
        ),
      );

      expect(errorView(isCompact: false), findsOneWidget);
      expect(errorView(isCompact: true), findsNothing);
      expect(find.byType(CategoryTile), findsNothing);
      // The claim under test: a dead getCategories does not take the
      // articles down with it.
      expect(find.byType(QuestionCard), findsNWidgets(questions.length));

      await tester.tap(
        find.descendant(
          of: errorView(isCompact: false),
          matching: find.byType(TextButton),
        ),
      );

      verify(() => bloc.add(const HomeEvent.refreshRequested())).called(1);
    });

    testWidgets('both sections can fail at once', (WidgetTester tester) async {
      await pumpHome(
        tester,
        const HomeState(
          questionsFailure: HomeFailure.network,
          categoriesFailure: HomeFailure.network,
        ),
      );

      expect(errorView(isCompact: true), findsOneWidget);
      expect(errorView(isCompact: false), findsOneWidget);
    });
  });

  group('search', () {
    testWidgets('typing dispatches the query', (WidgetTester tester) async {
      await pumpHome(
        tester,
        const HomeState(questions: questions, categories: categories),
      );

      await tester.enterText(find.byType(TextField), 'fern');

      verify(() => bloc.add(const HomeEvent.searchChanged('fern'))).called(1);
    });

    testWidgets('clearing the field dispatches the reset', (
      WidgetTester tester,
    ) async {
      await pumpHome(
        tester,
        const HomeState(questions: questions, categories: categories),
      );

      await tester.enterText(find.byType(TextField), 'fern');
      await tester.pump();

      // The clear affordance only exists once something is typed.
      await tester.tap(find.byType(IconButton));

      verify(() => bloc.add(const HomeEvent.searchCleared())).called(1);
    });

    testWidgets('a query narrows the grid and hides the carousel', (
      WidgetTester tester,
    ) async {
      await pumpHome(
        tester,
        const HomeState(
          questions: questions,
          categories: categories,
          query: 'fern',
        ),
      );

      expect(find.byType(CategoryTile), findsOneWidget);
      expect(find.byType(QuestionCard), findsNothing);
    });

    testWidgets('a query that matches nothing says so', (
      WidgetTester tester,
    ) async {
      await pumpHome(
        tester,
        const HomeState(categories: categories, query: 'orchid'),
      );

      expect(find.byType(CategoryTile), findsNothing);
      expect(find.text(tester.l10n.homeSearchEmpty('orchid')), findsOneWidget);
    });
  });

  testWidgets('tapping the premium banner reports the tap', (
    WidgetTester tester,
  ) async {
    int taps = 0;

    await pumpHome(
      tester,
      const HomeState(questions: questions, categories: categories),
      onPremiumTap: () => taps++,
    );

    await tester.tap(find.byType(HomePremiumBanner));
    await tester.pump();

    // The View only reports it; HomePage is what pushes the paywall.
    expect(taps, 1);
  });

  testWidgets('pull-to-refresh asks the Bloc to reload', (
    WidgetTester tester,
  ) async {
    await pumpHome(
      tester,
      const HomeState(questions: questions, categories: categories),
      surfaceSize: defaultSurface,
    );

    await tester.fling(
      find.byType(CustomScrollView),
      const Offset(0, 300),
      1000,
    );
    await tester.pumpAndSettle();

    verify(() => bloc.add(const HomeEvent.refreshRequested())).called(1);
  });

  testWidgets('the layout holds on a short viewport', (
    WidgetTester tester,
  ) async {
    await pumpHome(
      tester,
      const HomeState(questions: questions, categories: categories),
      surfaceSize: compactSurface,
    );

    // No overflow: the compact dimens scale is what keeps this green.
    expect(tester.takeException(), isNull);
    expect(find.byType(QuestionCard), findsWidgets);
  });
}
