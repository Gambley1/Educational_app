import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class GetUserService {
  Future<UserModel> getUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final token = storage.getString('ACCESS_TOKEN');
    final username = storage.getString('USERNAME');
    final email = storage.getString('EMAIL');
    if (token != null) {
      return UserModel(username: username, token: token, email: email);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
