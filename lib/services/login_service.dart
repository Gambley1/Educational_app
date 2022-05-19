import 'dart:convert';

import 'package:educational_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/client.dart';

class LoginService {
  Future<UserModel> login(String username, String password) async {
    final authUrl = Uri.http(host, "/auth/login");
    final data = {"username": username, "password": password};
    var userDataJson = json.encode(data);

    var resp = await client.post(authUrl,
        headers: {
          "Accept": "application/json",
        },
        body: userDataJson);

    var respTokenDict = json.decode(resp.body);
    var respToken = respTokenDict["access_token"];

    // var response = await client.get(
    //   teacherSubjectUrl,
    //   headers: {
    //     "Accept": "application/json",
    //     "Authorization": "Bearer " + respToken
    //   },
    // );

    if (resp.statusCode == 200) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      await storage.setString('ACCESS_TOKEN', respToken);
      await storage.setString('USERNAME', username);
      await storage.setString('PASSWORD', password);
      return UserModel(username: username, token: respToken);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
