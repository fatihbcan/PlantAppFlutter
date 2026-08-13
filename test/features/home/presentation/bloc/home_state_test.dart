import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/features/home/domain/entity/category.dart';
import 'package:hubx_flutter_case/features/home/domain/entity/question.dart';
import 'package:hubx_flutter_case/features/home/presentation/bloc/home_bloc.dart';

void main() {
  const List<Category> categories = <Category>[
    Category(id: 1, title: 'Ferns', imageUrl: ''),
    Category(id: 2, title: 'Cacti and Succulents', imageUrl: ''),
    Category(id: 3, title: 'Flowering Plants', imageUrl: ''),
  ];

  const List<Question> questions = <Question>[
    Question(
      id: 1,
      title: 'How to identify plants?',
      subtitle: 'Life Style',
      imageUrl: '',
      articleUrl: '',
    ),
  ];

  group('visibleCategories', () {
    test('returns every category when the query is empty', () {
      const HomeState state = HomeState(categories: categories);

      expect(state.visibleCategories, hasLength(3));
    });

    test('returns every category when the query is only whitespace', () {
      const HomeState state = HomeState(categories: categories, query: '   ');

      expect(state.visibleCategories, hasLength(3));
    });

    test('filters case-insensitively on a substring', () {
      const HomeState state = HomeState(categories: categories, query: 'cAcT');

      expect(state.visibleCategories, hasLength(1));
      expect(state.visibleCategories.single.title, 'Cacti and Succulents');
    });

    test('trims the query before matching', () {
      const HomeState state = HomeState(
        categories: categories,
        query: ' fern ',
      );

      expect(state.visibleCategories.single.title, 'Ferns');
    });

    test('returns empty when nothing matches', () {
      const HomeState state = HomeState(categories: categories, query: 'zzz');

      expect(state.visibleCategories, isEmpty);
    });
  });

  group('display flags', () {
    test('isInitialLoading is true only while both lists are empty', () {
      expect(const HomeState(isLoading: true).isInitialLoading, isTrue);
      expect(
        const HomeState(
          isLoading: true,
          categories: categories,
        ).isInitialLoading,
        isFalse,
      );
    });

    test('showsQuestions hides the carousel while searching', () {
      const HomeState idle = HomeState(questions: questions);
      const HomeState searching = HomeState(
        questions: questions,
        query: 'fern',
      );

      expect(idle.showsQuestions, isTrue);
      expect(searching.showsQuestions, isFalse);
    });

    test('showsQuestionsError only when the list is empty and it failed', () {
      expect(
        const HomeState(questionsFailure: HomeFailure.network)
            .showsQuestionsError,
        isTrue,
      );
      expect(
        const HomeState(
          questions: questions,
          questionsFailure: HomeFailure.network,
        ).showsQuestionsError,
        isFalse,
      );
    });

    test('showsCategoriesError only when the grid has nothing to show', () {
      expect(
        const HomeState(categoriesFailure: HomeFailure.server)
            .showsCategoriesError,
        isTrue,
      );
      expect(
        const HomeState(
          categories: categories,
          categoriesFailure: HomeFailure.server,
        ).showsCategoriesError,
        isFalse,
      );
    });

    test(
      'hasNoSearchResults distinguishes an empty search from empty data',
      () {
        expect(
          const HomeState(
            categories: categories,
            query: 'zzz',
          ).hasNoSearchResults,
          isTrue,
        );
        // No query: an empty grid is an empty data set, not a failed search.
        expect(const HomeState().hasNoSearchResults, isFalse);
      },
    );
  });
}
