import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decode/jwt_decode.dart';

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
      Map<String, dynamic> jwtPayload = Jwt.parseJwt(userinfo["jwt_token"]);
      Global.user = User(
          id: userinfo["id"],
          nickname: userinfo["nickname"],
          jwt: userinfo["jwt_token"],
          expireTime:
              DateTime.fromMillisecondsSinceEpoch(jwtPayload["exp"] * 1000)
                  .toIso8601String());
      Global.saveUser();
      notifyListeners();
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  // Register handler
  Future<bool> register(
      String username, String password, String nickname) async {
    try {
      final formData = FormData.fromMap(
          {"username": username, "password": password, "nickname": nickname});
      var response = await dio.post("/user/register",
          data: formData,
          options: Options(contentType: Headers.formUrlEncodedContentType));
      Map<String, dynamic> resp = jsonDecode(response.toString());
      if (resp["success"] == null || resp["success"] == false) {
        return false;
      }
      login(username, password);
      notifyListeners();
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  // Logout handler
  void logout() {
    Global.user = User(
        id: -1,
        nickname: "未登录",
        jwt: "empty",
        expireTime: DateTime(2020).toIso8601String());
    Global.saveUser();
    notifyListeners();
  }
}
