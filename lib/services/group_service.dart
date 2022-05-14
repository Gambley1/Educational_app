import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../models/group_model.dart';

class GroupService {
  static Future<List<Group>?> getListOfGroups() async {
    final url = Uri.http("192.168.1.166:8080", "/groups/list group");

    Dio _dio = Dio();

    Response resp = await _dio.get("192.168.1.166:8080/groups/list group");
    GroupResponse groupResponse = GroupResponse.fromJson(resp.data);

    return groupResponse.groups;
  }
}
