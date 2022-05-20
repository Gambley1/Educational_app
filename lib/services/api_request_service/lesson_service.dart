import 'package:educational_app/models/lesson_model.dart';
import 'package:educational_app/static/static_values.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LessonService {
  Future<List<Lesson>> getListOfLessons(String groupSubjectId) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final accessToken = storage.getString('ACCESS_TOKEN');
    final groupUrl = Uri.http(StaticValues.host, "/lesson/groupSubjectId", {
      "id": groupSubjectId,
      "resp":"mobile"
    });

    var resp = await StaticValues.client.get(
      groupUrl,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken!,
      },
    );
    if (kDebugMode) {
      print("from lessons service:" + resp.body);
    }
    if (resp.statusCode == 200) {
      var json = resp.body;
      return listLessonsFromJson(json);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}