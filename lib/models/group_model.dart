// To parse this JSON data, do
//
//     final group = groupFromJson(jsonString);

import 'dart:convert';

List<Group> groupFromJson(String str) =>
    List<Group>.from(json.decode(str).map((x) => Group.fromJson(x)));

String groupToJson(List<Group> group) =>
    json.encode(List<dynamic>.from(group.map((x) => x.toJson())));

class Group {
  Group({
    required this.id,
    required this.name,
    this.createdDate,
  });

  String id;
  String name;
  DateTime? createdDate;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json['id'],
        name: json['name'],
        createdDate: DateTime.parse(
            json['created_date'] ?? 'CREATED_AT is not available'),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'created_date': createdDate?.toIso8601String(),
      };
}
