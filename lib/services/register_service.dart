import 'dart:convert';

import 'package:educational_app/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterService {
  Future<UserModel> register(
      String email, String password, String username) async {
    try {
      var resp =
          await http.post(Uri.parse('https://reqres.in/api/users'), body: {
        'email': email,
        'password': password,
        'username': username,
      });

      var response = await http.get(
        Uri.parse('https://reqres.in/api/users'),
      );

      if (resp.statusCode == 201) {
        var respTokenDict = json.decode(resp.body);
        var respToken = respTokenDict["token"];
        SharedPreferences storage = await SharedPreferences.getInstance();
        await storage.setString('PASSWORD', password);
        await storage.setString('EMAIL', email);
        await storage.setString('USERNAME', username);
        // await storage.setString('TOKEN', respToken);
        print(json.decode(response.body));
        return UserModel(email: email, username: username);
      } else {
        throw Exception('Failed to load data!');
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
