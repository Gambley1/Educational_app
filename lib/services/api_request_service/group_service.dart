import 'dart:async';

import 'package:educational_app/models/group_model.dart';
import 'package:educational_app/models/user_group.dart';
import 'package:educational_app/services/api_client/base_client.dart';
import 'package:educational_app/services/controller/base_controller.dart';
import 'package:educational_app/static/static_values.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupService extends GetxController with BaseController {
  Future<Group> getCurrentGroup() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final accessToken = storage.getString('ACCESS_TOKEN');

    var resp = await BaseClientModel().getWithoutId(
      StaticValues.host,
      "/userGroup/token",
      {
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken!,
      },
    ).catchError(handleError);

    if (kDebugMode) {
      print("group body:" + resp);
    }

    if (resp != null) {
      List<UserGroup> userGroups = userGroupFromJson(resp);
      UserGroup currentUserGroup = userGroups[0];
      await storage.setString('GROUP_ID', currentUserGroup.groupId);
      return getGroupById(currentUserGroup.groupId);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<Group> getGroupById(String id) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final accessToken = storage.getString('ACCESS_TOKEN');
    final groupByIdUrl = Uri.http(StaticValues.host, "/group/id", {
      "id": id,
    });

    var res = await BaseClientModel().getWithId(
      StaticValues.host,
      "/group/id",
      {
        "id": id,
      },
      {
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken!,
      },
    ).catchError(handleError);

    if (kDebugMode) {
      print("group by id " + id + " " + res);
    }
    if (res != null) {
      var json = res;
      return oneGroupFromJson(json);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<List<Group>> getListOfGroups() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final accessToken = storage.getString('ACCESS_TOKEN');

    var resp = await BaseClientModel().getWithoutId(
      StaticValues.host,
      "/group",
      {
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken!,
      },
    ).catchError(handleError);

    if (resp != null) {
      var json = resp;
      return groupFromJson(json);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
