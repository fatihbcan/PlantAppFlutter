import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/core/network/app_exception.dart';
import 'package:hubx_flutter_case/core/network/json_decode_interceptor.dart';

void main() {
  const JsonDecodeInterceptor interceptor = JsonDecodeInterceptor();
  final RequestOptions options = RequestOptions(path: '/getQuestions');

  Response<dynamic> responseWith(dynamic body) =>
      Response<dynamic>(requestOptions: options, data: body);

  ({Response<dynamic>? passed, DioException? rejected}) run(dynamic body) {
    Response<dynamic>? passed;
    DioException? rejected;
    final _CapturingHandler handler = _CapturingHandler(
      onNext: (Response<dynamic> response) => passed = response,
      onReject: (DioException error) => rejected = error,
    );

    interceptor.onResponse(responseWith(body), handler);

    return (passed: passed, rejected: rejected);
  }

  test('decodes a JSON object served as text/plain', () {
    final result = run('{"data": [{"id": 1}]}');

    expect(result.passed!.data, isA<Map<String, dynamic>>());
    expect((result.passed!.data as Map<String, dynamic>)['data'], hasLength(1));
  });

  test('decodes a bare JSON array, which is what getQuestions returns', () {
    final result = run('[{"id": 1}, {"id": 2}]');

    expect(result.passed!.data, isA<List<dynamic>>());
    expect(result.passed!.data as List<dynamic>, hasLength(2));
  });

  test('leaves an already-decoded body untouched', () {
    final result = run(<String, dynamic>{'data': <dynamic>[]});

    expect(result.passed!.data, isA<Map<String, dynamic>>());
  });

  test('passes an empty body through rather than failing on it', () {
    final result = run('   ');

    expect(result.rejected, isNull);
    expect(result.passed!.data, '   ');
  });

  test('rejects unparseable text with a ParseException', () {
    final result = run('<html>nope</html>');

    expect(result.passed, isNull);
    expect(result.rejected!.error, isA<ParseException>());
  });
}

class _CapturingHandler extends ResponseInterceptorHandler {
  _CapturingHandler({required this.onNext, required this.onReject});

  final void Function(Response<dynamic>) onNext;
  final void Function(DioException) onReject;

  @override
  void next(Response<dynamic> response) => onNext(response);

  @override
  void reject(
    DioException error, [
    bool callFollowingErrorInterceptor = false,
  ]) => onReject(error);
}
