class UserModel {
  UserModel({
    this.email,
    this.password,
    this.token,
    this.username,
  });

  String? email;
  String? username;
  String? password;
  String? token;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        password: json["password"],
        token: json["token"],
      );
}
