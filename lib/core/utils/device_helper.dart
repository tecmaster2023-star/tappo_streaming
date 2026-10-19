import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceHelper {
  static Future<String> getDeviceId() async {
    final info = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final androidInfo = await info.androidInfo;
        return androidInfo.id ?? 'unknown-android';
      } else if (Platform.isIOS) {
        final iosInfo = await info.iosInfo;
        return iosInfo.identifierForVendor ?? 'unknown-ios';
      } else if (Platform.isTvOS) {
        final tvOsInfo = await info.tvOsInfo;
        return tvOsInfo.identifierForVendor ?? 'unknown-tvos';
      }
    } catch (e) {
      // fallback
    }
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static String get platformName {
    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    if (Platform.isTvOS) return 'tvos';
    if (Platform.isAndroidTV) return 'android_tv';
    return 'unknown';
  }
}
