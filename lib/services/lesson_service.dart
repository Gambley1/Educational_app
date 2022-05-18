import 'package:educational_app/models/lesson_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/client.dart';

class LessonService {
  Future<List<Lesson>> getListOfLessons(String groupSubjectId) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final accessToken = storage.getString('ACCESS_TOKEN');
    final groupUrl = Uri.http(host, "/lesson/groupSubjectId", {
      "id": groupSubjectId,
      "resp":"mobile"
    });

    var resp = await client.get(
      groupUrl,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken!,
      },
    );
    print("from lessons service:" + resp.body);
    if (resp.statusCode == 200) {
      var json = resp.body;
      return listLessonsFromJson(json);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}