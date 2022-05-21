import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

class UserModel {
  final String? username;
  final String token;

  UserModel({
    this.username,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json["access_token"],
        username: json["first_name"],
      );
}
