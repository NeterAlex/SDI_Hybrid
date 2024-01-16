import 'dart:convert';

import 'package:bruno/bruno.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/global.dart';
import '../common/http.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User get user => Global.user;

  // Login handler
  Future<bool> login(String username, String password) async {
    try {
      final formData =
          FormData.fromMap({"username": username, "password": password});
      var response = await dio.post("/user/login",
          data: formData,
          options: Options(contentType: Headers.formUrlEncodedContentType));
      Map<String, dynamic> resp = jsonDecode(response.toString());
      dynamic userinfo = resp["data"];
      if (userinfo == null) {
        return false;
      }
      if (kDebugMode) {
        print("Logged $userinfo");
      }
      Global.user = User(
          id: userinfo["id"],
          nickname: userinfo["nickname"],
          jwt: userinfo["jwt_token"]);
      Global.saveUser();
      notifyListeners();
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  // Logout handler
  void logout() {
    Global.user = User(id: -1, nickname: "未登录", jwt: "empty");
    Global.saveUser();
    notifyListeners();
  }
}
