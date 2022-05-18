import 'dart:convert';

List<Subject> subjectFromJson(String str) =>
    List<Subject>.from(json.decode(str).map((x) => Subject.fromJson(x)));

String subjectToJson(List<Subject> subject) =>
    json.encode(List<dynamic>.from(subject.map((x) => x.toJson())));

class Subject {
  String name;
  String description;
  String id;

  Subject({
    required this.name,
    required this.description,
    required this.id,
  });

  factory Subject.fromJson(Map<String, dynamic> subject) => Subject(
        id: subject['id'],
        description: subject['description'],
        name: subject['name'],
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
      };
}
