import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:sdi_hybrid/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'http.dart';

class Global {
  static late SharedPreferences _prefs;
  static User user = User(
      id: -1,
      nickname: "未登录",
      jwt: "empty",
      expireTime: DateTime(2020).toIso8601String());

  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    var savedUser = _prefs.getString("user");
    if (savedUser != null) {
      try {
        user = User.fromJson(jsonDecode(savedUser));
        final timeNow = DateTime.now();
        if (timeNow.isAfter(DateTime.parse(user.expireTime))) {
          user = User(
              id: -1,
              nickname: "未登录",
              jwt: "empty",
              expireTime: DateTime(2020).toIso8601String());
          saveUser();
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    await configureDio();
  }

  // Save user
  static void saveUser() {
    if (kDebugMode) {
      print("Logged ${user.nickname}");
    }
    _prefs.setString("user", jsonEncode(user.toJson()));
  }
}
