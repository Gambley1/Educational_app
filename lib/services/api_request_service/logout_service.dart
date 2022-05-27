import 'package:shared_preferences/shared_preferences.dart';

class LogOutService {
  Future<bool> logout() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final accessToken = storage.getString('ACCESS_TOKEN');
    if (accessToken != null) {
      await storage.remove('ACCESS_TOKEN');
      return true;
    } else {
      return false;
    }
  }
}
