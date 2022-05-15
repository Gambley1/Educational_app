import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:educational_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  Future<UserModel> login(String username, String password) async {
    final authUrl = Uri.http("192.168.1.166:5000", "/auth/login");
    final teacherSubjectUrl = Uri.http("192.168.1.166:5000", "/teacherSubject");
    final data = {"username": username, "password": password};
    var userDataJson = json.encode(data);

    var resp = await http.post(authUrl,
        headers: {
          "Accept": "application/json",
        },
        body: userDataJson);

    var respTokenDict = json.decode(resp.body);
    var respToken = respTokenDict["access_token"];

    var response = await http.get(
      teacherSubjectUrl,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer " + respToken
      },
    );

    if (resp.statusCode == 200) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      await storage.setString('TOKEN', respToken);
      await storage.setString('USERNAME', username);
      await storage.setString('PASSWORD', password);
      print(json.decode(response.body));
      return UserModel(username: username, token: respToken);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<UserModel> getUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final token = storage.getString('TOKEN');
    final username = storage.getString('USERNAME');
    final email = storage.getString('EMAIL');
    if (token != null) {
      return UserModel(username: username, token: token, email: email);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<bool> logout() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final username = storage.getString('USERNAME');
    final token = storage.getString('TOKEN');
    final email = storage.getString('EMAIL');
    if (token != null) {
      await storage.remove('TOKEN');
      await storage.remove('PASSWORD');
      await storage.remove('EMAIL');
      await storage.remove('USERNAME');
      return true;
    } else {
      return false;
    }
  }
}
