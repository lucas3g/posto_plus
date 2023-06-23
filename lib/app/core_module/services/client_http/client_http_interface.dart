import 'package:posto_plus/app/core_module/services/client_http/dio_client_http.dart';

abstract class IClientHttp {
  Future<BaseResponse> get(String path);
  Future<BaseResponse> post(String path, {dynamic data});
  Future<BaseResponse> put(String path, {dynamic data});
  Future<BaseResponse> upload(String path, {List<int>? data});
  Future<BaseResponse> delete(String path);
  void setBaseUrl(String url);
  void setHeaders(Map<String, String> header);
  void addInterceptor(DioInterceptor interceptor);
  void removeInterceptor(DioInterceptor interceptor);
}

class BaseResponse {
  final int statusCode;
  final dynamic data;
  final BaseRequest request;

  const BaseResponse(this.data, this.request, [this.statusCode = 200]);
}

class BaseRequest {
  final String url;
  final dynamic data;
  final Map<String, String> headers;
  final String method;

  BaseRequest({
    required this.url,
    this.data,
    this.headers = const {},
    required this.method,
  });
}

class BaseError implements Exception {
  final Exception? exception;
  final String message;
  final StackTrace? stackTrace;
  final BaseRequest? request;

  const BaseError(this.message,
      [this.request, this.stackTrace, this.exception]);

  @override
  String toString() {
    return '''$runtimeType: $message. ${stackTrace == null ? '' : '\n$stackTrace'}''';
  }
}
