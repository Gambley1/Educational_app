import 'dart:convert';

import 'package:educational_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/client.dart';

class RegisterService {
  Future<UserModel> register(String password, String username) async {
    var authRegisterUrl = Uri.http("192.168.1.166:5000", "/auth/register");
    String accessToken =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2Nlc3NfdXVpZCI6IjM1ODU1YzQ2LTMzZmItNGFjMi05ZWZkLTdiZmMyNGMwNDQxNyIsImF1dGhvcml6ZWQiOnRydWUsImV4cCI6MTY1MjkwMTY5MSwidXNlcl9pZCI6ImI4ZDE3ZDE0LWRhODgtNDA0ZS1iZmQ3LWM1M2YxZThmZmJiYyIsInVzZXJfdHlwZSI6ImFkbWluIn0.2klbfrsKZ8jIwyZ3VL7_pxLAs-soPOGrnMIzHKMUjlM";
    final data = {"username": username, "password": password};
    var userDataJson = json.encode(data);
    try {
      var resp = await client.post(
        authRegisterUrl,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer " + accessToken
        },
        body: userDataJson,
      );

      var respBodyDict = json.decode(resp.body);
      var respId = respBodyDict['id'];

      if (resp.statusCode == 200) {
        var respTokenDict = json.decode(resp.body);
        var respToken = respTokenDict["access_token"];
        SharedPreferences storage = await SharedPreferences.getInstance();
        await storage.setString('PASSWORD', password);
        await storage.setString('ID', respId);
        await storage.setString('USERNAME', username);
        await storage.setString('ACCESS_TOKEN', respToken);
        return UserModel(username: username, token: respToken, id: respId);
      } else {
        throw Exception('Failed to load data!');
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
