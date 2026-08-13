import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/core/network/app_exception.dart';
import 'package:hubx_flutter_case/features/home/data/datasource/home_remote_data_source.dart';
import 'package:hubx_flutter_case/features/home/data/dto/category_dto.dart';
import 'package:hubx_flutter_case/features/home/data/dto/question_dto.dart';
import 'package:hubx_flutter_case/features/home/data/repository/home_repository_impl.dart';
import 'package:hubx_flutter_case/features/home/domain/result/home_results.dart';
import 'package:mocktail/mocktail.dart';

class _MockRemote extends Mock implements HomeRemoteDataSource {}

void main() {
  late _MockRemote remote;
  late HomeRepositoryImpl repository;

  setUp(() {
    remote = _MockRemote();
    repository = HomeRepositoryImpl(remote);
  });

  /// Shapes the exception the way it actually reaches the repository in
  /// production: wrapped in a DioException by the error interceptor.
  DioException wrapped(AppException exception) => DioException(
    requestOptions: RequestOptions(path: '/x'),
    error: exception,
  );

  group('getCategories', () {
    test('returns success with mapped, rank-sorted entities', () async {
      when(() => remote.fetchCategories()).thenAnswer(
        (_) async => const <CategoryDto>[
          CategoryDto(id: 2, title: 'Second', rank: 1),
          CategoryDto(id: 1, title: 'First', rank: 0),
        ],
      );

      final GetCategoriesResult result = await repository.getCategories();

      expect(result, isA<GetCategoriesSuccess>());
      final GetCategoriesSuccess success = result as GetCategoriesSuccess;
      expect(success.categories.first.title, 'First');
      expect(success.categories, hasLength(2));
    });

    test('maps a wrapped NetworkException to the network case', () async {
      when(() => remote.fetchCategories())
          .thenThrow(wrapped(const NetworkException()));

      expect(await repository.getCategories(), isA<GetCategoriesNetwork>());
    });

    test(
      'maps a ServerException to the server case, keeping the code',
      () async {
        when(() => remote.fetchCategories())
            .thenThrow(wrapped(const ServerException(503)));

        final GetCategoriesResult result = await repository.getCategories();

        expect(result, isA<GetCategoriesServer>());
        expect((result as GetCategoriesServer).statusCode, 503);
      },
    );

    test('maps a ParseException thrown directly by the source', () async {
      when(() => remote.fetchCategories())
          .thenThrow(const ParseException('bad shape'));

      expect(await repository.getCategories(), isA<GetCategoriesParse>());
    });

    test('maps an unrecognised error to the unknown case', () async {
      when(() => remote.fetchCategories()).thenThrow(StateError('boom'));

      expect(await repository.getCategories(), isA<GetCategoriesUnknown>());
    });
  });

  group('getQuestions', () {
    test('returns success with order-sorted entities', () async {
      when(() => remote.fetchQuestions()).thenAnswer(
        (_) async => const <QuestionDto>[
          QuestionDto(id: 2, title: 'B', order: 2),
          QuestionDto(id: 1, title: 'A', order: 1),
        ],
      );

      final GetQuestionsResult result = await repository.getQuestions();

      expect(result, isA<GetQuestionsSuccess>());
      expect((result as GetQuestionsSuccess).questions.first.title, 'A');
    });

    test('maps a wrapped NetworkException to the network case', () async {
      when(() => remote.fetchQuestions())
          .thenThrow(wrapped(const NetworkException()));

      expect(await repository.getQuestions(), isA<GetQuestionsNetwork>());
    });

    test('maps a ServerException to the server case', () async {
      when(() => remote.fetchQuestions())
          .thenThrow(wrapped(const ServerException(500)));

      expect(await repository.getQuestions(), isA<GetQuestionsServer>());
    });

    test('maps a ParseException to the parse case', () async {
      when(() => remote.fetchQuestions()).thenThrow(const ParseException());

      expect(await repository.getQuestions(), isA<GetQuestionsParse>());
    });

    test('maps a cancellation to unknown rather than surfacing it', () async {
      when(() => remote.fetchQuestions())
          .thenThrow(wrapped(const CancelledException()));

      expect(await repository.getQuestions(), isA<GetQuestionsUnknown>());
    });
  });
}
