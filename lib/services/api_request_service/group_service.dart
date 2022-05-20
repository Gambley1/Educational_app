import 'package:educational_app/models/group_model.dart';
import 'package:educational_app/models/user_group.dart';
import 'package:educational_app/services/controller/base_controller.dart';
import 'package:educational_app/static/static_values.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class GroupService extends GetxController with BaseController {
  Future<Group> getCurrentGroup() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final accessToken = storage.getString('ACCESS_TOKEN');
    final groupUrl = Uri.http(StaticValues.host, "/userGroup/token");

    var resp = await StaticValues.client.get(
      groupUrl,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken!,
      },
    );
    if (kDebugMode) {
      print("group body:" + resp.body);
    }

    if (resp.statusCode == 200) {
      List<UserGroup> userGroups = userGroupFromJson(resp.body);
      UserGroup currentUserGroup = userGroups[0];
      await storage.setString('GROUP_ID', currentUserGroup.groupId);
      return getGroupById(currentUserGroup.groupId);
    } else {
      hideLoading();
      throw Exception('Failed to load data!');
    }
  }

  Future<Group> getGroupById(String id) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final accessToken = storage.getString('ACCESS_TOKEN');
    final groupByIdUrl = Uri.http(StaticValues.host, "/group/id", {
      "id": id,
    });

    var res = await StaticValues.client.get(
      groupByIdUrl,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken!,
      },
    );
    if (kDebugMode) {
      print("group by id " + id + " " + res.body);
    }
    if (res.statusCode == 200) {
      var json = res.body;
      return oneGroupFromJson(json);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<List<Group>> getListOfGroups() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final accessToken = storage.getString('ACCESS_TOKEN');
    final groupUrl = Uri.http(StaticValues.host, "/group");

    var resp = await StaticValues.client.get(
      groupUrl,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken!,
      },
    );

    if (resp.statusCode == 200) {
      var json = resp.body;
      return groupFromJson(json);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
