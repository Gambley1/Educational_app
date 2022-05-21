import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';

class GetUserService {
  Future<UserModel> getUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final accessToken = storage.getString('ACCESS_TOKEN');
    final username = storage.getString('USERNAME');
    if (accessToken != null) {
      return UserModel(username: username!, token: accessToken);
    } else {
      throw Exception('Token is null');
    }
  }
}
