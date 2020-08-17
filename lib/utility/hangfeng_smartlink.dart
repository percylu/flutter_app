import 'dart:async';

import 'package:flutter/services.dart';

class HanfengSmartlink {
  static const MethodChannel _channel = const MethodChannel('hanfeng_smartlink');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> startLink(String wifi,String pwd) async {
    return await _channel.invokeMethod<String>(
      'startLink',{"wifi":wifi,"password":pwd});
  }

}