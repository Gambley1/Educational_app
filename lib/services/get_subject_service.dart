import 'package:shared_preferences/shared_preferences.dart';

import '../constants/client.dart';
import '../models/subjects_model.dart';

class GetSubjectService {
  Future<List<Subject>> getListOfSubject() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final accessToken = storage.getString('ACCESS_TOKEN');
    final subjectUrl = Uri.http("192.168.1.166:5000", "/subjects");

    var response = await client.get(subjectUrl, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer " + accessToken!,
    });

    if (response.statusCode == 200) {
      var responseDataFromJson = response.body;
      return subjectFromJson(responseDataFromJson);
    } else {
      throw Exception('Something went wrong!');
    }
  }
}
