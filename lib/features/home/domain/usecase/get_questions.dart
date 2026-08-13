import 'package:hubx_flutter_case/features/home/domain/repository/home_repository.dart';
import 'package:hubx_flutter_case/features/home/domain/result/home_results.dart';
import 'package:injectable/injectable.dart';

/// Loads the "get started" articles carousel.
@injectable
class GetQuestions {
  const GetQuestions(this._repository);

  final HomeRepository _repository;

  Future<GetQuestionsResult> call() => _repository.getQuestions();
}
