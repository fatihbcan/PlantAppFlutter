part of 'home_bloc.dart';

/// UI-facing failure categories, mapped from the domain result unions.
enum HomeFailure { network, server, parse, unknown }

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default(<Question>[]) List<Question> questions,
    @Default(<Category>[]) List<Category> categories,
    @Default('') String query,
    @Default(null) HomeFailure? questionsFailure,
    @Default(null) HomeFailure? categoriesFailure,
  }) = _HomeState;

  const HomeState._();

  /// Categories narrowed by the search field.
  ///
  /// Filtering lives here, not in `build()`, so it is unit-testable without
  /// pumping a widget tree.
  List<Category> get visibleCategories {
    if (query.trim().isEmpty) return categories;
    final String needle = query.trim().toLowerCase();
    return categories
        .where((Category c) => c.title.toLowerCase().contains(needle))
        .toList(growable: false);
  }

  bool get isSearching => query.trim().isNotEmpty;

  /// The articles carousel is hidden while searching — the design shows
  /// search results as a category list only.
  bool get showsQuestions => !isSearching && questions.isNotEmpty;

  bool get showsQuestionsError =>
      !isSearching && questions.isEmpty && questionsFailure != null;

  bool get showsCategoriesError =>
      categories.isEmpty && categoriesFailure != null;

  /// True when there is genuinely nothing on screen yet.
  bool get isInitialLoading =>
      isLoading && questions.isEmpty && categories.isEmpty;

  /// A search that matched nothing, as opposed to an empty data set.
  bool get hasNoSearchResults => isSearching && visibleCategories.isEmpty;
}
