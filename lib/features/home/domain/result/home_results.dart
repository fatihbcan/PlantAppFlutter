import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hubx_flutter_case/features/home/domain/entity/category.dart';
import 'package:hubx_flutter_case/features/home/domain/entity/question.dart';

part 'home_results.freezed.dart';

/// Outcome of loading the category grid.
///
/// One union per operation, consumed with an exhaustive switch: adding a
/// failure mode later becomes a compile error at every call site rather than
/// slipping through a `default:`.
@freezed
sealed class GetCategoriesResult with _$GetCategoriesResult {
  const factory GetCategoriesResult.success(List<Category> categories) =
      GetCategoriesSuccess;
  const factory GetCategoriesResult.network() = GetCategoriesNetwork;
  const factory GetCategoriesResult.server(int statusCode) =
      GetCategoriesServer;
  const factory GetCategoriesResult.parse() = GetCategoriesParse;
  const factory GetCategoriesResult.unknown([Object? cause]) =
      GetCategoriesUnknown;
}

/// Outcome of loading the "get started" articles.
@freezed
sealed class GetQuestionsResult with _$GetQuestionsResult {
  const factory GetQuestionsResult.success(List<Question> questions) =
      GetQuestionsSuccess;
  const factory GetQuestionsResult.network() = GetQuestionsNetwork;
  const factory GetQuestionsResult.server(int statusCode) = GetQuestionsServer;
  const factory GetQuestionsResult.parse() = GetQuestionsParse;
  const factory GetQuestionsResult.unknown([Object? cause]) =
      GetQuestionsUnknown;
}
