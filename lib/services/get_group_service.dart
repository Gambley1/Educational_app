import 'package:educational_app/constants/client.dart';
import 'package:educational_app/models/group_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetGroupService {
  Future<List<Group>> getListOfGroups() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final accessToken = storage.getString('ACCESS_TOKEN');
    final groupUrl = Uri.http("192.168.1.166:5000", "/group");

    var resp = await client.get(
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
