import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hubx_flutter_case/core/network/app_exception.dart';

/// Turns every [DioException] into an [AppException] before it reaches a
/// data source.
///
/// This is the single place that knows about status codes and socket
/// failures. Repositories below it only ever see the four sealed cases.
class ErrorInterceptor extends Interceptor {
  const ErrorInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: _translate(err),
      ),
    );
  }

  AppException _translate(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const NetworkException('The connection timed out');
      case DioExceptionType.connectionError:
        return const NetworkException();
      case DioExceptionType.cancel:
        return const CancelledException();
      case DioExceptionType.badCertificate:
        return const NetworkException('The server certificate was rejected');
      case DioExceptionType.badResponse:
        final int status = err.response?.statusCode ?? 0;
        return ServerException(status, _messageForStatus(status));
      case DioExceptionType.unknown:
        if (err.error is SocketException) return const NetworkException();
        if (err.error is FormatException) return const ParseException();
        return UnknownNetworkException(
          err.message ?? 'Unexpected error',
          err.error,
        );
    }
  }

  String _messageForStatus(int status) {
    if (status == HttpStatus.unauthorized) return 'Session expired';
    if (status == HttpStatus.forbidden) return 'Access denied';
    if (status == HttpStatus.notFound) return 'Resource not found';
    if (status >= 500) return 'The server is unavailable';
    return 'Request failed';
  }
}
