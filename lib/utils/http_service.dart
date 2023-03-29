import 'package:dio/dio.dart';

import 'fib_logger.dart';

class HttpService {
  String? _token;
  late final Dio dio;
  HttpService._() {
    dio = Dio(BaseOptions(
        baseUrl:
            'https://mobile.fcb-sd.com:8181/IBMiddleware/webresources/IBWebservices'));
    dio.interceptors.add(_BaseDioInterceptors());
    // dio.interceptors.add(FcbCardInterceptor());
  }
  static HttpService? _instance;
  static HttpService get instance {
    _instance ??= HttpService._();
    return _instance!;
  }

  /// returns Authorization Token if any exists
  String get token => _token ?? '';

  /// sets the Authorization token if any exists
  set token(String value) {
    _token = value;
  }
}

class _BaseDioInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    FibLogger.i('RequestInformation ${[
      options.path,
      options.method,
      options.data,
      options.queryParameters,
      options.headers
    ]}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    FibLogger.d('RequestResponse ${[
      response.data,
      response.headers,
      response.statusCode
    ]}');
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    FibLogger.e('OnRequest Error', err, err.stackTrace);
    handler.next(err);
  }
}
