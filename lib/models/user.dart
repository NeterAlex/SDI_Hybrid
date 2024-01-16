class User {
  int id;
  String nickname;
  String jwt;

  User({
    required this.id,
    required this.nickname,
    required this.jwt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nickname: json['nickname'],
      jwt: json['jwt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickname': nickname,
      'jwt': jwt,
    };
  }
}
