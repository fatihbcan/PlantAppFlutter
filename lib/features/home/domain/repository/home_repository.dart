import 'package:hubx_flutter_case/features/home/domain/result/home_results.dart';

/// Read access to the home screen's two collections.
///
/// No implementation may throw across this boundary; every failure is a case
/// of the operation's result union.
abstract interface class HomeRepository {
  Future<GetCategoriesResult> getCategories();

  Future<GetQuestionsResult> getQuestions();
}
