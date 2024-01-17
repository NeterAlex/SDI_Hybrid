class User {
  int id;
  String nickname;
  String jwt;
  String expireTime;

  User(
      {required this.id,
      required this.nickname,
      required this.jwt,
      required this.expireTime});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        nickname: json['nickname'],
        jwt: json['jwt'],
        expireTime: json['expireTime']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickname': nickname,
      'jwt': jwt,
      'expireTime': expireTime
    };
  }
}
