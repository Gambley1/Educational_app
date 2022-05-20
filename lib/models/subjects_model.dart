import 'dart:convert';

List<Subject> subjectFromJson(String str) =>
    List<Subject>.from(json.decode(str).map((x) => Subject.fromJson(x)));

class Subject {
  String name;
  String description;
  String id;

  Subject({
    required this.name,
    required this.description,
    required this.id,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        name: json["name"],
        description: json["description"],
        id: json["id"],
      );
}
