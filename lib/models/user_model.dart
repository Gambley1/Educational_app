class UserModel {
  UserModel({
    this.email,
    this.password,
    this.token,
    this.username,
    this.id,
  });

  String? email;
  String? username;
  String? password;
  String? token;
  String? id;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'] ?? 'Почта Недоступна',
        password: json['password'] ?? 'Пароль Недоступнен',
        token: json['access_token'] ?? 'Токен Недоступнен',
        username: json['username'] ?? 'Имя Недоступно',
        id: json['id'] ?? 'Id недоступен',
      );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> userData = <String, dynamic>{};
    userData['email'] = email;
    userData['password'] = password;
    userData['access_token'] = token;
    userData['username'] = username;
    userData['id'] = id;
    return userData;
  }
}
