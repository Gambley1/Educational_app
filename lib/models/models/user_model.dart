import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

class UserModel {
  final String token;
  final String username;
  final bool? isTeacher;
  UserModel({
    required this.token,
    required this.username,
    this.isTeacher,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json["access_token"] ?? '',
        username: json["username"] ?? '',
        isTeacher: json["isTeacher"] ?? false,
      );
}
