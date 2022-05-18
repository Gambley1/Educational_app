import 'dart:convert';

import 'package:educational_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/client.dart';

class RegisterService {
  Future<UserModel> register(String password, String username) async {
    var authRegisterUrl = Uri.http("192.168.1.166:5000", "/auth/register");
    String accessToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2Nlc3NfdXVpZCI6ImQ0MGYzMzgwLTJiNjItNDU1Ni04MTc3LTRjMmNhZGNlMGVhOCIsImF1dGhvcml6ZWQiOnRydWUsImV4cCI6MTY1MjgxODE5MSwidXNlcl9pZCI6ImVmNTQwNDg3LTVhMzMtNDI3Ni1iYWIzLTBjMjI1YjVlM2U4YSIsInVzZXJfdHlwZSI6ImFkbWluIn0.SZ-gUbmmo1kDtH-zk56wr81Xiy5SfrL8YeV-LJE2bvY';
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

      if (resp.statusCode == 200) {
        var respTokenDict = json.decode(resp.body);
        var respToken = respTokenDict["access_token"];
        SharedPreferences storage = await SharedPreferences.getInstance();
        await storage.setString('PASSWORD', password);
        await storage.setString('USERNAME', username);
        await storage.setString('ACCESS_TOKEN', respToken);
        return UserModel(username: username, token: respToken);
      } else {
        throw Exception('Failed to load data!');
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
