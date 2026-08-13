import 'package:dio/dio.dart';
import 'package:hubx_flutter_case/core/network/api_config.dart';
import 'package:hubx_flutter_case/core/network/app_exception.dart';
import 'package:hubx_flutter_case/features/home/data/dto/category_dto.dart';
import 'package:hubx_flutter_case/features/home/data/dto/question_dto.dart';
import 'package:injectable/injectable.dart';

/// Talks to the case API and hands back DTOs.
///
/// Transport failures arrive already translated by `ErrorInterceptor`; this
/// class only adds the parse step, so a payload of the wrong shape becomes a
/// [ParseException] rather than a raw [TypeError].
abstract interface class HomeRemoteDataSource {
  Future<List<CategoryDto>> fetchCategories({CancelToken? cancelToken});

  Future<List<QuestionDto>> fetchQuestions({CancelToken? cancelToken});
}

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  const HomeRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<CategoryDto>> fetchCategories({CancelToken? cancelToken}) async {
    final Response<dynamic> response = await _dio.get<dynamic>(
      ApiConfig.categories,
      cancelToken: cancelToken,
    );

    final dynamic body = response.data;
    if (body is! Map<String, dynamic>) {
      throw const ParseException('Expected a categories envelope object');
    }

    try {
      return CategoriesResponseDto.fromJson(body).data;
    } on Object catch (error) {
      throw ParseException('Malformed category payload: $error');
    }
  }

  @override
  Future<List<QuestionDto>> fetchQuestions({CancelToken? cancelToken}) async {
    final Response<dynamic> response = await _dio.get<dynamic>(
      ApiConfig.questions,
      cancelToken: cancelToken,
    );

    final dynamic body = response.data;
    if (body is! List<dynamic>) {
      throw const ParseException('Expected a questions array');
    }

    try {
      return body
          .cast<Map<String, dynamic>>()
          .map(QuestionDto.fromJson)
          .toList(growable: false);
    } on Object catch (error) {
      throw ParseException('Malformed question payload: $error');
    }
  }
}
