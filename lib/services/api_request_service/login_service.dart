import 'dart:convert';

import 'package:educational_app/models/user_model.dart';
import 'package:educational_app/services/api_client/base_client.dart';
import 'package:educational_app/services/controller/base_controller.dart';
import 'package:educational_app/services/helper/dialog_helper.dart';
import 'package:educational_app/static/static_values.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_client/app_exceptions.dart';

class LoginService extends GetxController with BaseController {
  Future<UserModel> login(String username, String password) async {
    final data = {"username": username, "password": password};
    // var userDataJson = json.encode(data);

    showLoading("Posting data...");
    var resp = await BaseClientModel()
        .post(
            StaticValues.host,
            "/auth/login",
            {
              "Accept": "application/json",
            },
            data)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErrorDialog(description: apiError["reason"]);
      } else {
        handleError(error);
      }
    });

    var respTokenDict = json.decode(resp);
    var respToken = respTokenDict["access_token"];

    if (resp != null) {
      hideLoading();
      SharedPreferences storage = await SharedPreferences.getInstance();
      await storage.setString('ACCESS_TOKEN', respToken);
      await storage.setString('USERNAME', username);
      await storage.setString('PASSWORD', password);
      return UserModel(username: username, token: respToken);
    } else {
      hideLoading();
      throw Exception('Failed to load data!');
    }
  }
}
