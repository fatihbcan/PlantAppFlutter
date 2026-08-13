import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hubx_flutter_case/core/network/app_exception.dart';
import 'package:hubx_flutter_case/core/network/error_interceptor.dart';

void main() {
  const ErrorInterceptor interceptor = ErrorInterceptor();
  final RequestOptions options = RequestOptions(path: '/getCategories');

  /// Runs the interceptor and returns the AppException it attached.
  AppException translate(DioException error) {
    late AppException captured;
    final ErrorInterceptorHandler handler = _CapturingHandler(
      (DioException rejected) => captured = rejected.error! as AppException,
    );

    interceptor.onError(error, handler);

    return captured;
  }

  group('transport failures', () {
    test('connection errors become NetworkException', () {
      final AppException result = translate(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
        ),
      );

      expect(result, isA<NetworkException>());
    });

    test('every timeout flavour becomes NetworkException', () {
      for (final DioExceptionType type in <DioExceptionType>[
        DioExceptionType.connectionTimeout,
        DioExceptionType.sendTimeout,
        DioExceptionType.receiveTimeout,
      ]) {
        final AppException result = translate(
          DioException(requestOptions: options, type: type),
        );

        expect(result, isA<NetworkException>(), reason: '$type');
        expect(result.message, contains('timed out'));
      }
    });

    test('a raw SocketException becomes NetworkException', () {
      final AppException result = translate(
        DioException(
          requestOptions: options,
          error: const SocketException('no route'),
        ),
      );

      expect(result, isA<NetworkException>());
    });

    test('cancellation is its own case, not an error to show', () {
      final AppException result = translate(
        DioException(requestOptions: options, type: DioExceptionType.cancel),
      );

      expect(result, isA<CancelledException>());
    });
  });

  group('status-code validation', () {
    test('404 keeps its code and gets a specific message', () {
      final AppException result = translate(
        DioException(
          requestOptions: options,
          type: DioExceptionType.badResponse,
          response: Response<void>(requestOptions: options, statusCode: 404),
        ),
      );

      expect(result, isA<ServerException>());
      expect((result as ServerException).statusCode, 404);
      expect(result.message, 'Resource not found');
    });

    test('401 is reported as an expired session', () {
      final AppException result = translate(
        DioException(
          requestOptions: options,
          type: DioExceptionType.badResponse,
          response: Response<void>(requestOptions: options, statusCode: 401),
        ),
      );

      expect((result as ServerException).message, 'Session expired');
    });

    test('5xx is reported as the server being unavailable', () {
      final AppException result = translate(
        DioException(
          requestOptions: options,
          type: DioExceptionType.badResponse,
          response: Response<void>(requestOptions: options, statusCode: 503),
        ),
      );

      expect((result as ServerException).statusCode, 503);
      expect(result.message, 'The server is unavailable');
    });
  });

  group('payload failures', () {
    test('a FormatException becomes ParseException', () {
      final AppException result = translate(
        DioException(
          requestOptions: options,
          error: const FormatException('not json'),
        ),
      );

      expect(result, isA<ParseException>());
    });

    test('anything else falls through to UnknownNetworkException', () {
      final AppException result = translate(
        DioException(requestOptions: options, error: StateError('???')),
      );

      expect(result, isA<UnknownNetworkException>());
    });
  });
}

/// Captures what the interceptor rejects with, instead of forwarding it.
class _CapturingHandler extends ErrorInterceptorHandler {
  _CapturingHandler(this.onReject);

  final void Function(DioException) onReject;

  @override
  void reject(
    DioException error, [
    bool callFollowingErrorInterceptor = false,
  ]) => onReject(error);
}
