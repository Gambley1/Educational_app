import 'package:educational_app/models/subejct_additional_model.dart';
import 'package:educational_app/static/static_values.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubjectService {
  Future<List<MySubjectOverall>> getListOfSubjects() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final accessToken = storage.getString('ACCESS_TOKEN');
    final id = storage.getString("GROUP_ID");
    final groupUrl = Uri.http(StaticValues.host, "/subjects/groupId", {
      "group_id": id,
    });

    var resp = await StaticValues.client.get(
      groupUrl,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken!,
      },
    );
    if (kDebugMode) {
      print("from subject service:" + resp.body);
    }
    if (resp.statusCode == 200) {
      var json = resp.body;
      return listSubjectOverall(json);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
