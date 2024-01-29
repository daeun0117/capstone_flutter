import 'dart:core';

class UserModel {
  final String loginId;
  final String password;
  final String email;
  final String nickname;
  final String findLoginId;
  final String newPassword;

  UserModel({
    required this.loginId,
    required this.password,
    required this.email,
    required this.nickname,
    required this.findLoginId,
    required this.newPassword,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      loginId: json["loginId"],
      password: json["password"],
      email: json["email"],
      nickname: json["nickname"],
      findLoginId: json["findLoginId"],
      newPassword: json["newPassword"],
    );
  }
}
