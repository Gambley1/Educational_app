import 'package:shared_preferences/shared_preferences.dart';

import '../../models/models.dart';

class GetUserService {
  Future<UserModel> getUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final accessToken = storage.getString('ACCESS_TOKEN');
    final username = storage.getString('USERNAME');
    return UserModel(
        username: username ?? '', token: accessToken!);
  }
}
