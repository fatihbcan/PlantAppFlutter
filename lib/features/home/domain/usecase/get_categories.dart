import 'package:hubx_flutter_case/features/home/domain/repository/home_repository.dart';
import 'package:hubx_flutter_case/features/home/domain/result/home_results.dart';
import 'package:injectable/injectable.dart';

/// Loads the plant categories shown in the home grid.
@injectable
class GetCategories {
  const GetCategories(this._repository);

  final HomeRepository _repository;

  Future<GetCategoriesResult> call() => _repository.getCategories();
}
