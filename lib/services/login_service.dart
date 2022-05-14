import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:educational_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  Future<UserModel> login(String email, String password) async {
    final url = Uri.parse("https://reqres.in/api/login");
    final data = {"email": email, "password": password};

    var resp = await http.post(url, body: data);

    var respTokenDict = json.decode(resp.body); 
    var respToken = respTokenDict["access_token"];
    if (resp.statusCode == 200) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      final body = json.decode (resp.body);
      await storage.setString('TOKEN', body['token']);
      await storage.setString('EMAIL', email);
      return UserModel(email: email, token: body['token']);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<UserModel> getUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final token = storage.getString('TOKEN');
    final email = storage.getString('EMAIL');
    if (token != null && email != null) {
      return UserModel(email: email, token: token);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<bool> logout() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final email = storage.getString('email');
    final token = storage.getString('TOKEN');
    if (email != null && token != null) {
      await storage.remove('TOKEN');
      await storage.remove('email');
      return true;
    } else {
      return false;
    }
  }
}
