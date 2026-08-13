import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hubx_flutter_case/features/home/domain/entity/category.dart';
import 'package:hubx_flutter_case/features/home/domain/entity/question.dart';
import 'package:hubx_flutter_case/features/home/domain/result/home_results.dart';
import 'package:hubx_flutter_case/features/home/domain/usecase/get_categories.dart';
import 'package:hubx_flutter_case/features/home/domain/usecase/get_questions.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_transform/stream_transform.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

/// Loads the two home collections and owns the search query.
///
/// Both requests run concurrently and each failure is tracked separately, so
/// a dead categories endpoint still leaves the articles carousel usable.
@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._getQuestions, this._getCategories) : super(const HomeState()) {
    on<HomeStarted>(_onLoad, transformer: droppable());
    // Droppable: mashing retry or pulling to refresh repeatedly must not fan
    // out into overlapping requests.
    on<HomeRefreshRequested>(_onLoad, transformer: droppable());
    on<HomeSearchChanged>(
      _onSearchChanged,
      transformer: _debounceRestartable(),
    );
    on<HomeSearchCleared>(_onSearchCleared, transformer: sequential());
  }

  static const Duration _searchDebounce = Duration(milliseconds: 250);

  final GetQuestions _getQuestions;
  final GetCategories _getCategories;

  /// Search is local, but debouncing still avoids a rebuild per keystroke,
  /// and `restartable` is what a server-side search would need.
  EventTransformer<HomeSearchChanged> _debounceRestartable() {
    return (
      Stream<HomeSearchChanged> events,
      EventMapper<HomeSearchChanged> mapper,
    ) {
      return restartable<HomeSearchChanged>()(
        events.debounce(_searchDebounce),
        mapper,
      );
    };
  }

  Future<void> _onLoad(HomeEvent event, Emitter<HomeState> emit) async {
    emit(
      state.copyWith(
        isLoading: true,
        questionsFailure: null,
        categoriesFailure: null,
      ),
    );

    // Fired together rather than awaited in sequence: the two endpoints are
    // independent, so home paints roughly twice as fast.
    final (GetQuestionsResult questions, GetCategoriesResult categories) =
        await (_getQuestions(), _getCategories()).wait;

    HomeState next = state.copyWith(isLoading: false);

    switch (questions) {
      case GetQuestionsSuccess(:final List<Question> questions):
        next = next.copyWith(questions: questions, questionsFailure: null);
      case GetQuestionsNetwork():
        next = next.copyWith(questionsFailure: HomeFailure.network);
      case GetQuestionsServer():
        next = next.copyWith(questionsFailure: HomeFailure.server);
      case GetQuestionsParse():
        next = next.copyWith(questionsFailure: HomeFailure.parse);
      case GetQuestionsUnknown():
        next = next.copyWith(questionsFailure: HomeFailure.unknown);
    }

    switch (categories) {
      case GetCategoriesSuccess(:final List<Category> categories):
        next = next.copyWith(categories: categories, categoriesFailure: null);
      case GetCategoriesNetwork():
        next = next.copyWith(categoriesFailure: HomeFailure.network);
      case GetCategoriesServer():
        next = next.copyWith(categoriesFailure: HomeFailure.server);
      case GetCategoriesParse():
        next = next.copyWith(categoriesFailure: HomeFailure.parse);
      case GetCategoriesUnknown():
        next = next.copyWith(categoriesFailure: HomeFailure.unknown);
    }

    emit(next);
  }

  void _onSearchChanged(HomeSearchChanged event, Emitter<HomeState> emit) {
    if (event.query == state.query) return;
    emit(state.copyWith(query: event.query));
  }

  void _onSearchCleared(HomeSearchCleared event, Emitter<HomeState> emit) {
    if (state.query.isEmpty) return;
    emit(state.copyWith(query: ''));
  }
}
