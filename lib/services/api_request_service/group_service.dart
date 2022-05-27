import 'dart:async';

import 'package:educational_app/services/api_client/base_client.dart';
import 'package:educational_app/services/controller/base_controller.dart';
import 'package:educational_app/static/static_values.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/models.dart';

class GroupService extends GetxController with BaseController {
  Future<GroupModel> getCurrentGroup() async {
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

    List<UserGroup> userGroups = userGroupFromJson(resp);
    UserGroup currentUserGroup = userGroups[0];
    await storage.setString('GROUP_ID', currentUserGroup.groupId);
    Future<GroupModel> groupById = getGroupById(currentUserGroup.groupId);
    return groupById;
  }

  Future<GroupModel> getGroupById(String id) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final accessToken = storage.getString('ACCESS_TOKEN');

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

    GroupModel group = groupFromJson(res);
    return group;
  }

  Future<List<GroupModel>> getGroups() async {
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

    List<GroupModel> groups = groupsFromJson(resp);
    return groups;
  }
}
