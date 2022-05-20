class UserModel {
  final String username;
  final String token;

  UserModel({
    required this.username,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json["access_token"],
        username: json["username"],
      );
}
