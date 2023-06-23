import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posto_plus/app/core_module/services/shared_preferences/adapters/shared_params.dart';
import 'package:posto_plus/app/core_module/services/shared_preferences/local_storage_interface.dart';

import 'client_http_interface.dart';

class DioClientHttp implements IClientHttp {
  final Dio _dio;

  DioClientHttp(this._dio);

  final _interceptors = <DioInterceptor>[];

  @override
  void setBaseUrl(String url) {
    _dio.options.baseUrl = url;
  }

  @override
  void setHeaders(Map<String, String> header) {
    _dio.options.headers = header;
  }

  @override
  Future<BaseResponse> get(String path) async {
    final response = await _dio.get(path);
    return _responseAdapter(response);
  }

  @override
  Future<BaseResponse> post(
    String path, {
    dynamic data,
  }) async {
    final response = await _dio.post(path, data: data);
    return _responseAdapter(response);
  }

  @override
  Future<BaseResponse> delete(String path) async {
    final response = await _dio.delete(path);
    return _responseAdapter(response);
  }

  @override
  Future<BaseResponse> put(
    String path, {
    dynamic data,
  }) async {
    final response = await _dio.put(path, data: data);
    return _responseAdapter(response);
  }

  @override
  Future<BaseResponse> upload(
    String path, {
    List<int>? data,
  }) async {
    final response = await _dio.post(path, data: data);
    return _responseAdapter(response);
  }

  BaseResponse _responseAdapter(Response response) {
    return BaseResponse(
      response.data,
      BaseRequest(
        url: response.requestOptions.path,
        method: response.requestOptions.method,
        headers: response.requestOptions.headers.cast(),
        data: response.requestOptions.data,
      ),
    );
  }

  @override
  void addInterceptor(DioInterceptor interceptor) {
    _interceptors.add(interceptor);
  }

  @override
  void removeInterceptor(DioInterceptor interceptor) {
    _interceptors.remove(interceptor);
  }
}

class DioInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final options = response.requestOptions;

    if (options.method == 'GET') {
      final shared = Modular.get<ILocalStorage>();

      await shared.setData(
        params: SharedParams(
          key: options.path,
          value: response.data,
        ),
      );
    }

    handler.resolve(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final shared = Modular.get<ILocalStorage>();

    final data = shared.getData(err.requestOptions.path);

    if (data != null) {
      handler.resolve(Response(requestOptions: err.requestOptions, data: data));
    } else {
      handler.next(err);
    }
  }
}
