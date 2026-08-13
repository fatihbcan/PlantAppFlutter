import 'package:dio/dio.dart';
import 'package:hubx_flutter_case/core/network/app_exception.dart';
import 'package:hubx_flutter_case/features/home/data/datasource/home_remote_data_source.dart';
import 'package:hubx_flutter_case/features/home/data/dto/category_dto.dart';
import 'package:hubx_flutter_case/features/home/data/dto/question_dto.dart';
import 'package:hubx_flutter_case/features/home/data/mapper/home_mappers.dart';
import 'package:hubx_flutter_case/features/home/domain/repository/home_repository.dart';
import 'package:hubx_flutter_case/features/home/domain/result/home_results.dart';
import 'package:injectable/injectable.dart';

/// Thin translation layer: call the source, map DTOs, turn exceptions into
/// result cases. No business rules live here.
@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._remote);

  final HomeRemoteDataSource _remote;

  @override
  Future<GetCategoriesResult> getCategories() async {
    try {
      final List<CategoryDto> dtos = await _remote.fetchCategories();
      return GetCategoriesResult.success(dtos.toEntities());
    } on Object catch (error) {
      return switch (_asAppException(error)) {
        NetworkException() => const GetCategoriesResult.network(),
        ServerException(:final int statusCode) => GetCategoriesResult.server(
          statusCode,
        ),
        ParseException() => const GetCategoriesResult.parse(),
        // A cancelled request is not a user-visible failure, but the caller
        // still needs a terminal value; treat it as unknown and let the Bloc
        // decide (it drops the emission).
        CancelledException() => const GetCategoriesResult.unknown(),
        UnknownNetworkException(:final Object? cause) =>
          GetCategoriesResult.unknown(cause),
        null => GetCategoriesResult.unknown(error),
      };
    }
  }

  @override
  Future<GetQuestionsResult> getQuestions() async {
    try {
      final List<QuestionDto> dtos = await _remote.fetchQuestions();
      return GetQuestionsResult.success(dtos.toEntities());
    } on Object catch (error) {
      return switch (_asAppException(error)) {
        NetworkException() => const GetQuestionsResult.network(),
        ServerException(:final int statusCode) => GetQuestionsResult.server(
          statusCode,
        ),
        ParseException() => const GetQuestionsResult.parse(),
        CancelledException() => const GetQuestionsResult.unknown(),
        UnknownNetworkException(:final Object? cause) =>
          GetQuestionsResult.unknown(cause),
        null => GetQuestionsResult.unknown(error),
      };
    }
  }

  /// Unwraps the [AppException] the interceptor attached to a [DioException],
  /// or recognises one thrown directly by a data source.
  AppException? _asAppException(Object error) {
    if (error is AppException) return error;
    if (error is DioException && error.error is AppException) {
      return error.error! as AppException;
    }
    return null;
  }
}
