/// The only exception type allowed to leave the network layer.
///
/// Dio's own [DioException] is translated into one of these by
/// `ErrorInterceptor`, so repositories catch a small closed set instead of
/// re-deriving meaning from status codes and socket errors.
sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// No usable connection: DNS failure, timeout, socket dropped.
final class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection']);
}

/// The server answered, but not with success.
final class ServerException extends AppException {
  const ServerException(this.statusCode, [super.message = 'Server error']);

  final int statusCode;

  @override
  String toString() => 'ServerException($statusCode): $message';
}

/// The payload did not have the shape the DTO expects.
final class ParseException extends AppException {
  const ParseException([super.message = 'Malformed response']);
}

/// The request was cancelled by a [CancelToken] — a normal outcome when a
/// screen is disposed mid-flight, not an error to show the user.
final class CancelledException extends AppException {
  const CancelledException([super.message = 'Request cancelled']);
}

/// Anything the interceptor could not classify.
final class UnknownNetworkException extends AppException {
  const UnknownNetworkException([
    super.message = 'Unexpected error',
    this.cause,
  ]);

  final Object? cause;
}
