import 'dart:convert';

import 'package:educational_app/models/group_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/data_model.dart';

class GroupService {
  ResponseData? groupResponse;
  late List<Datum>? groups;

  Future<List<Datum>?> getListOfGroups() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final accessToken = storage.getString('TOKEN');
    final groupUrl = Uri.parse("https://reqres.in/api/unknown");

    var resp = await http.get(
      groupUrl,
    );
    var responseData = json.decode(resp.body);

    if (resp.statusCode == 200) {
      groupResponse = ResponseData.fromJson(responseData);
      groups = groupResponse!.data;
      return groups;
    } else {
      throw Exception('Failde to load data!');
    }
  }
}
