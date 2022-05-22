import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

class UserModel {
  final String token;
  final String? username;

  UserModel({
    required this.token,
    this.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json["access_token"],
        username: json["username"],
      );
}
