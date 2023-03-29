import 'package:dio/dio.dart';
import 'package:fib/utils/fib_info.dart';
import 'package:fib/utils/http_service.dart';
import 'package:uuid/uuid.dart';

abstract class BaseHttpService {
  final HttpService _httpService = HttpService.instance;
  String get path;

  Future<Response<dynamic>> post(
      {required Map<String, dynamic> body,
      Map<String, dynamic>? queryParams}) async {
    return _httpService.dio
        .post(path, data: extendedData(body), queryParameters: queryParams);
  }

  Future<Response<dynamic>> put(
      {required Map<String, dynamic> data,
      String? path,
      Map<String, dynamic>? queryParams}) {
    return _httpService.dio
        .put(path ?? this.path, data: data, queryParameters: queryParams);
  }

  Future<Response<dynamic>> get(
      {String params = '', Map<String, dynamic>? queryParams}) {
    return _httpService.dio.get(
      path + params,
      queryParameters: queryParams,
    );
  }

  Future<Response<dynamic>> uploadImage({required FormData formData}) {
    return _httpService.dio.post(path,
        options: Options(contentType: 'multipart/form-data'), data: formData);
  }

  set token(String value) {
    _httpService.token = value;
  }

  String get token => _httpService.token;
  Map<String, dynamic> extendedData(Map<String, dynamic> json) {
    json.addAll({
      "uuid": const Uuid().v4(),
      "ChannelID": FcbInfo.instance.platform,
      "Authentication": "Account",
      "lang": FcbInfo.instance.langCode,
      "DeviceID": FcbInfo.instance.deviceId,
      "AppId": "Tirhal",
      "userId": const Uuid().v4(),
      "key": "",
      "versionCode": FcbInfo.instance.buildNumber
    });
    return json;
  }
}
