import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hubx_flutter_case/core/network/app_exception.dart';

/// Decodes bodies the server sent as JSON but labelled something else.
///
/// The case API answers `getCategories` and `getQuestions` with
/// `content-type: text/plain`, so Dio's transformer leaves the body as a raw
/// [String]. Decoding here keeps that quirk in one place instead of making
/// every data source guess at the type it received.
class JsonDecodeInterceptor extends Interceptor {
  const JsonDecodeInterceptor();

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final dynamic body = response.data;

    if (body is! String || body.trim().isEmpty) {
      handler.next(response);
      return;
    }

    try {
      response.data = jsonDecode(body);
      handler.next(response);
    } on FormatException catch (error) {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: ParseException('Response was not JSON: ${error.message}'),
        ),
      );
    }
  }
}
