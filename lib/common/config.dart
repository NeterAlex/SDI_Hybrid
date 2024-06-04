import 'dart:convert';

import 'package:flutter/services.dart';

class ConfigHelper {
  static Future<Config> getConfig() async {
    var configString = await rootBundle.loadString('assets/config/config.json');
    Map<String, dynamic> jsonMap = jsonDecode(configString);
    var config = Config.fromJson(jsonMap);
    return config;
  }
}

class Config {
  String serverUrl;

  Config({required this.serverUrl});

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
        serverUrl: json["server_url"] ?? "https://sdi.api.agricserv.cn");
  }
}
