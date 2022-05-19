import 'package:educational_app/models/subejct_additional_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:educational_app/constants/client.dart';

class SubjectService {
  Future<List<MySubjectOverall>> getListOfSubjects() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final accessToken = storage.getString('ACCESS_TOKEN');
    final id = storage.getString("GROUP_ID");
    final groupUrl = Uri.http(host, "/subjects/groupId", {
      "group_id": id,
    });

    var resp = await client.get(
      groupUrl,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer " + accessToken!,
      },
    );
    print("from subject service:" + resp.body);
    if (resp.statusCode == 200) {
      var json = resp.body;
      return listSubjectOverall(json);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
