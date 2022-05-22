// To parse this JSON data, do
//
//     final group = groupFromJson(jsonString);

import 'dart:convert';

List<GroupModel> groupsFromJson(String str) =>
    List<GroupModel>.from(json.decode(str).map((x) => GroupModel.fromJson(x)));

GroupModel oneGroupFromJson(String str) =>
    GroupModel.fromJson(json.decode(str));

class GroupModel {
  final String id;
  final String name;
  final String createdDate;
  GroupModel({
    required this.id,
    required this.name,
    required this.createdDate,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        id: json["id"],
        name: json["name"],
        createdDate: json["created_date"],
      );
}
