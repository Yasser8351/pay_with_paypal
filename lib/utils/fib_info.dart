import 'dart:io';

import 'package:flutter/material.dart';
import 'package:platform_device_id/platform_device_id.dart';

class FcbInfo {
  String? _buildNumber;
  Locale? _locale;
  String? _deviceId;
  FcbInfo._();
  static FcbInfo? _instance;
  static FcbInfo get instance {
    if (_instance == null) throw 'not init';
    return _instance!;
  }

  static getDeviceId() async {
    var deviceId = await PlatformDeviceId.getDeviceId;
    return deviceId;
  }

  static void initFcbInfo({
    String? buildNumber,
    Locale? currentLocale,
    String? deviceId,
  }) {
    _instance ??= FcbInfo._();
    _instance!._buildNumber = buildNumber;
    _instance!._locale = currentLocale;
    _instance!._deviceId = deviceId ?? getDeviceId();
  }

  String get buildNumber => _buildNumber ?? '1';
  String get platform => Platform.isIOS ? 'IOS' : 'Android';
  String get langCode {
    if (_locale == null) return "1";
    return _locale!.languageCode == "en" ? "1" : "0";
  }

  String get deviceId => _deviceId ?? getDeviceId();

  set locale(Locale locale) {
    _locale = locale;
  }
}
