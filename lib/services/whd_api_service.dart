import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:whd_app/core/api_exception.dart';

class WhdApiService {
  WhdApiService({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: dotenv.env['WHD_BASE_URL'] ?? 'default_url',
              connectTimeout: const Duration(seconds: 5),
              receiveTimeout: const Duration(seconds: 5),
            ),
          ) {
    _dio.interceptors.add(
      LogInterceptor(request: true, requestBody: true, responseBody: true),
    );
  }

  final Dio _dio;

  ApiException handleDioError(DioException e) {
    final statusCode = e.response?.statusCode;

    if (e.type == DioExceptionType.connectionTimeout) {
      return ApiException(message: "Connection timeout", code: statusCode);
    }

    if (e.type == DioExceptionType.receiveTimeout) {
      return ApiException(
        message: "Server took too long to respond",
        code: statusCode,
      );
    }

    if (e.type == DioExceptionType.badResponse) {
      final msg = e.response?.data.toString() ?? "Something went wrong";
      return ApiException(message: msg, code: statusCode);
    }

    if (e.type == DioExceptionType.connectionError) {
      return ApiException(message: "No internet connection", code: statusCode);
    }

    return ApiException(
      message: "Request failed: ${e.message}",
      code: statusCode,
    );
  }

  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await _dio.get(url, queryParameters: query);
      return response.data;
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw ApiException(message: "unexpected error");
    }
  }

  Future<dynamic> post({
    required String url,
    required dynamic requestBody,
  }) async {
    try {
      final response = await _dio.post(url, data: requestBody);
      return response.data;
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw ApiException(message: "Unexpected error: $e");
    }
  }
}
