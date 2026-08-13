import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/features/home/domain/repository/home_repository.dart';
import 'package:hubx_flutter_case/features/home/domain/result/home_results.dart';
import 'package:hubx_flutter_case/features/home/domain/usecase/get_categories.dart';
import 'package:hubx_flutter_case/features/home/domain/usecase/get_questions.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepository extends Mock implements HomeRepository {}

void main() {
  late _MockRepository repository;

  setUp(() => repository = _MockRepository());

  group('GetCategories', () {
    test('passes success through', () async {
      when(() => repository.getCategories())
          .thenAnswer((_) async => const GetCategoriesResult.success([]));

      expect(await GetCategories(repository)(), isA<GetCategoriesSuccess>());
    });

    test('passes the network case through', () async {
      when(() => repository.getCategories())
          .thenAnswer((_) async => const GetCategoriesResult.network());

      expect(await GetCategories(repository)(), isA<GetCategoriesNetwork>());
    });

    test('passes the server case through', () async {
      when(() => repository.getCategories())
          .thenAnswer((_) async => const GetCategoriesResult.server(500));

      expect(await GetCategories(repository)(), isA<GetCategoriesServer>());
    });

    test('passes the parse case through', () async {
      when(() => repository.getCategories())
          .thenAnswer((_) async => const GetCategoriesResult.parse());

      expect(await GetCategories(repository)(), isA<GetCategoriesParse>());
    });

    test('passes the unknown case through', () async {
      when(() => repository.getCategories())
          .thenAnswer((_) async => const GetCategoriesResult.unknown());

      expect(await GetCategories(repository)(), isA<GetCategoriesUnknown>());
    });
  });

  group('GetQuestions', () {
    test('passes success through', () async {
      when(() => repository.getQuestions())
          .thenAnswer((_) async => const GetQuestionsResult.success([]));

      expect(await GetQuestions(repository)(), isA<GetQuestionsSuccess>());
    });

    test('passes the network case through', () async {
      when(() => repository.getQuestions())
          .thenAnswer((_) async => const GetQuestionsResult.network());

      expect(await GetQuestions(repository)(), isA<GetQuestionsNetwork>());
    });

    test('passes the server case through', () async {
      when(() => repository.getQuestions())
          .thenAnswer((_) async => const GetQuestionsResult.server(503));

      expect(await GetQuestions(repository)(), isA<GetQuestionsServer>());
    });

    test('passes the parse case through', () async {
      when(() => repository.getQuestions())
          .thenAnswer((_) async => const GetQuestionsResult.parse());

      expect(await GetQuestions(repository)(), isA<GetQuestionsParse>());
    });

    test('passes the unknown case through', () async {
      when(() => repository.getQuestions())
          .thenAnswer((_) async => const GetQuestionsResult.unknown());

      expect(await GetQuestions(repository)(), isA<GetQuestionsUnknown>());
    });
  });
}
