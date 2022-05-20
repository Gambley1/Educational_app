// To parse this JSON data, do
//
//     final group = groupFromJson(jsonString);

import 'dart:convert';

List<Group> groupFromJson(String str) =>
    List<Group>.from(json.decode(str).map((x) => Group.fromJson(x)));

Group oneGroupFromJson(String str) =>
    Group.fromJson(json.decode(str));

class Group {
  Group({
    required this.id,
    required this.name,
    required this.createdDate,
  });

  String id;
  String name;
  String createdDate;

  factory Group.fromJson(Map<String, dynamic> json) =>
      Group(
        id: json["id"],
        name: json["name"],
        createdDate: json["created_date"],
      );
}
