import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../common/global.dart';
import '../common/http.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  late User _user = Global.user;

  User get user => _user;

  Future<void> login(String username, String password) async {
    var response = await dio.post("/user/login",
        data: {"username": username, "password": password},
        options: Options(contentType: Headers.formUrlEncodedContentType));
    Map<String, dynamic> resp = jsonDecode(response.toString());
    dynamic userinfo = resp["data"];
    _user = User(
        id: int.parse(userinfo["id"]),
        nickname: userinfo["nickname"],
        jwt: userinfo["jwt_token"]);
    Global.saveUser();
    notifyListeners();
  }

  void logout() {
    _user = User(id: -1, nickname: "未登录", jwt: "empty");
    Global.saveUser();
    notifyListeners();
  }
}
