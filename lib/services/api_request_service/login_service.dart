import 'dart:convert';

import 'package:educational_app/services/api_client/base_client.dart';
import 'package:educational_app/services/controller/base_controller.dart';
import 'package:educational_app/services/helper/dialog_helper.dart';
import 'package:educational_app/static/static_values.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/models.dart';
import '../api_client/app_exceptions.dart';

class LoginService extends GetxController with BaseController {
  Future<UserModel> login(String username, String password) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final data = {"username": username, "password": password};

    showLoading("Posting data...");
    var resp = await BaseClientModel()
        .post(
            StaticValues.host,
            "/auth/login",
            {
              "Accept": "application/json",
            },
            data)
        .catchError(
      (error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          DialogHelper.showErrorDialog(description: apiError["reason"]);
        } else {
          handleError(error);
        }
      },
    );

    hideLoading();
    var respTokenDict = json.decode(resp);
    var respToken = respTokenDict["access_token"];
    await storage.setString('ACCESS_TOKEN', respToken);
    await storage.setString('USERNAME', username);
    await storage.setString('PASSWORD', password);
    UserModel user = UserModel(token: respToken, username: username);
    return user;
  }
}
