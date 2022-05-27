import 'package:educational_app/services/api_client/base_client.dart';
import 'package:educational_app/services/controller/base_controller.dart';
import 'package:educational_app/static/static_values.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/models.dart';

class LessonService extends GetxController with BaseController {
  Future<List<Lesson>> getListOfLessons(String groupSubjectId) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final accessToken = storage.getString('ACCESS_TOKEN');

    var resp = await BaseClientModel().getWithId(
      StaticValues.host,
      "/lesson/groupSubjectId",
      {"id": groupSubjectId, "resp": "mobile"},
      {
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken!,
      },
    ).catchError(handleError);
    if (kDebugMode) {
      print("from lessons service:" + resp);
    }

    List<Lesson> lessons = listLessonsFromJson(resp);
    return lessons;
  }
}
