import 'package:shared_preferences/shared_preferences.dart';

class LogOutService {
  Future<bool> logout() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final accessToken = storage.getString('ACCESS_TOKEN');
    final email = storage.getString('EMAIL');
    if (accessToken != null || email != null) {
      await storage.remove('ACCESS_TOKEN');
      await storage.remove('PASSWORD');
      await storage.remove('EMAIL');
      await storage.remove('USERNAME');
      return true;
    } else {
      return false;
    }
  }
}
