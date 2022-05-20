import 'package:educational_app/services/controller/base_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';

class GetUserService extends GetxController with BaseController {
  Future<UserModel> getUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final accessToken = storage.getString('ACCESS_TOKEN');
    final username = storage.getString('USERNAME');
    showLoading('Loading...');
    if (accessToken != null) {
      hideLoading();
      return UserModel(username: username!, token: accessToken);
    } else {
      hideLoading();
      throw Exception('Token is null');
    }
  }
}
