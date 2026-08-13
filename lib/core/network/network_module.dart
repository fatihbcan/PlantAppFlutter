import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hubx_flutter_case/core/network/api_config.dart';
import 'package:hubx_flutter_case/core/network/error_interceptor.dart';
import 'package:injectable/injectable.dart';

/// Provides the single configured [Dio] instance to the graph.
@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        sendTimeout: ApiConfig.sendTimeout,
        // Anything outside 2xx becomes a DioException, which the error
        // interceptor then turns into a ServerException.
        validateStatus: (int? status) =>
            status != null && status >= 200 && status < 300,
      ),
    );

    dio.interceptors.add(const ErrorInterceptor());

    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor());
    }

    return dio;
  }
}
