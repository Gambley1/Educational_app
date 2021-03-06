import 'package:educational_app/services/api_client/base_client.dart';
import 'package:educational_app/services/controller/base_controller.dart';
import 'package:educational_app/static/static_values.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/models.dart';

class SubjectService extends GetxController with BaseController {
  Future<List<MySubjectOverall>> getListOfSubjects() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final accessToken = storage.getString('ACCESS_TOKEN');
    final id = storage.getString('GROUP_ID');
    var resp = await BaseClientModel()
        .getWithId(StaticValues.host, "/subjects/groupId", {
      "group_id": id,
    }, {
      "Accept": "application/json",
      "Authorization": "Bearer " + accessToken!,
    }).catchError(handleError);

    if (kDebugMode) {
      print("from subject service:" + resp);
    }

    List<MySubjectOverall> mySubjectOverall = listMySubjectOverall(resp);
    return mySubjectOverall;
  }
}
