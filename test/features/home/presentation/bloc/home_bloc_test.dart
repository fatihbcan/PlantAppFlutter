import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/features/home/domain/entity/category.dart';
import 'package:hubx_flutter_case/features/home/domain/entity/question.dart';
import 'package:hubx_flutter_case/features/home/domain/result/home_results.dart';
import 'package:hubx_flutter_case/features/home/domain/usecase/get_categories.dart';
import 'package:hubx_flutter_case/features/home/domain/usecase/get_questions.dart';
import 'package:hubx_flutter_case/features/home/presentation/bloc/home_bloc.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetCategories extends Mock implements GetCategories {}

class _MockGetQuestions extends Mock implements GetQuestions {}

void main() {
  late _MockGetCategories getCategories;
  late _MockGetQuestions getQuestions;

  const List<Category> categories = <Category>[
    Category(id: 1, title: 'Ferns', imageUrl: 'a.png'),
    Category(id: 2, title: 'Cacti', imageUrl: 'b.png'),
  ];
  const List<Question> questions = <Question>[
    Question(
      id: 1,
      title: 'How to identify plants?',
      subtitle: 'Life Style',
      imageUrl: 'c.png',
      articleUrl: 'https://example.com',
    ),
  ];

  setUp(() {
    getCategories = _MockGetCategories();
    getQuestions = _MockGetQuestions();
  });

  void stubSuccess() {
    when(() => getCategories())
        .thenAnswer((_) async => const GetCategoriesResult.success(categories));
    when(() => getQuestions())
        .thenAnswer((_) async => const GetQuestionsResult.success(questions));
  }

  HomeBloc build() => HomeBloc(getQuestions, getCategories);

  group('started', () {
    blocTest<HomeBloc, HomeState>(
      'emits loading then both collections on success',
      setUp: stubSuccess,
      build: build,
      act: (HomeBloc bloc) => bloc.add(const HomeEvent.started()),
      expect: () => <HomeState>[
        const HomeState(isLoading: true),
        const HomeState(categories: categories, questions: questions),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'keeps the categories when only the questions endpoint fails',
      setUp: () {
        when(() => getCategories()).thenAnswer(
          (_) async => const GetCategoriesResult.success(categories),
        );
        when(() => getQuestions())
            .thenAnswer((_) async => const GetQuestionsResult.network());
      },
      build: build,
      act: (HomeBloc bloc) => bloc.add(const HomeEvent.started()),
      expect: () => <HomeState>[
        const HomeState(isLoading: true),
        const HomeState(
          categories: categories,
          questionsFailure: HomeFailure.network,
        ),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'records each failure category separately',
      setUp: () {
        when(() => getCategories())
            .thenAnswer((_) async => const GetCategoriesResult.server(500));
        when(() => getQuestions())
            .thenAnswer((_) async => const GetQuestionsResult.parse());
      },
      build: build,
      act: (HomeBloc bloc) => bloc.add(const HomeEvent.started()),
      verify: (HomeBloc bloc) {
        expect(bloc.state.categoriesFailure, HomeFailure.server);
        expect(bloc.state.questionsFailure, HomeFailure.parse);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'drops overlapping loads instead of firing duplicate requests',
      // The stubs must take real time: droppable only drops events that
      // arrive while a handler is still in flight, and an instantly
      // completing mock never overlaps with anything.
      setUp: () {
        when(() => getCategories()).thenAnswer(
          (_) => Future<GetCategoriesResult>.delayed(
            const Duration(milliseconds: 50),
            () => const GetCategoriesResult.success(categories),
          ),
        );
        when(() => getQuestions()).thenAnswer(
          (_) => Future<GetQuestionsResult>.delayed(
            const Duration(milliseconds: 50),
            () => const GetQuestionsResult.success(questions),
          ),
        );
      },
      build: build,
      act: (HomeBloc bloc) => bloc
        ..add(const HomeEvent.started())
        ..add(const HomeEvent.started())
        ..add(const HomeEvent.started()),
      wait: const Duration(milliseconds: 120),
      verify: (_) {
        verify(() => getCategories()).called(1);
        verify(() => getQuestions()).called(1);
      },
    );
  });

  group('refreshRequested', () {
    blocTest<HomeBloc, HomeState>(
      'clears a previous failure before reloading',
      setUp: stubSuccess,
      build: build,
      seed: () => const HomeState(categoriesFailure: HomeFailure.network),
      act: (HomeBloc bloc) => bloc.add(const HomeEvent.refreshRequested()),
      expect: () => <HomeState>[
        const HomeState(isLoading: true),
        const HomeState(categories: categories, questions: questions),
      ],
    );
  });

  group('search', () {
    blocTest<HomeBloc, HomeState>(
      'stores the debounced query',
      build: build,
      act: (HomeBloc bloc) => bloc.add(const HomeEvent.searchChanged('fern')),
      wait: const Duration(milliseconds: 300),
      expect: () => <HomeState>[const HomeState(query: 'fern')],
    );

    blocTest<HomeBloc, HomeState>(
      'debounce keeps only the last keystroke of a burst',
      build: build,
      act: (HomeBloc bloc) => bloc
        ..add(const HomeEvent.searchChanged('f'))
        ..add(const HomeEvent.searchChanged('fe'))
        ..add(const HomeEvent.searchChanged('fern')),
      wait: const Duration(milliseconds: 300),
      expect: () => <HomeState>[const HomeState(query: 'fern')],
    );

    blocTest<HomeBloc, HomeState>(
      'ignores a repeat of the current query',
      build: build,
      seed: () => const HomeState(query: 'fern'),
      act: (HomeBloc bloc) => bloc.add(const HomeEvent.searchChanged('fern')),
      wait: const Duration(milliseconds: 300),
      expect: () => <HomeState>[],
    );

    blocTest<HomeBloc, HomeState>(
      'searchCleared resets the query',
      build: build,
      seed: () => const HomeState(categories: categories, query: 'fern'),
      act: (HomeBloc bloc) => bloc.add(const HomeEvent.searchCleared()),
      expect: () => <HomeState>[const HomeState(categories: categories)],
    );

    blocTest<HomeBloc, HomeState>(
      'searchCleared is a no-op when nothing is typed',
      build: build,
      act: (HomeBloc bloc) => bloc.add(const HomeEvent.searchCleared()),
      expect: () => <HomeState>[],
    );
  });
}
