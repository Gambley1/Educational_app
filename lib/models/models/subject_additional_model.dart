import 'dart:convert';

MySubject oneMySubjectFromJson(String str) =>
    MySubject.fromJson(json.decode(str));

class MySubject {
  final String id;
  final String name;
  final String description;
  final String createdDate;
  MySubject({
    required this.id,
    required this.name,
    required this.description,
    required this.createdDate,
  });

  factory MySubject.fromJson(Map<String, dynamic> json) => MySubject(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        description: json["description"] ?? '',
        createdDate: json["created_date"] ?? '',
      );
}

MyTeacherSubject oneMyTeacherSubjectFromJson(String str) =>
    MyTeacherSubject.fromJson(json.decode(str));

class MyTeacherSubject {
  final String id;
  final String teacherId;
  final String subjectId;
  final String createdDate;
  MyTeacherSubject({
    required this.id,
    required this.teacherId,
    required this.subjectId,
    required this.createdDate,
  });

  factory MyTeacherSubject.fromJson(Map<String, dynamic> json) =>
      MyTeacherSubject(
        id: json["id"] ?? '',
        teacherId: json["teacher_id"] ?? '',
        subjectId: json["subject_id"] ?? '',
        createdDate: json["created_date"] ?? '',
      );
}

MyGroupSubject oneMyGroupSubjectFromJson(String str) =>
    MyGroupSubject.fromJson(json.decode(str));

class MyGroupSubject {
  final String id;
  final String groupId;
  final String teacherSubjectId;
  final String createdDate;
  MyGroupSubject({
    required this.id,
    required this.groupId,
    required this.teacherSubjectId,
    required this.createdDate,
  });

  factory MyGroupSubject.fromJson(Map<String, dynamic> json) => MyGroupSubject(
        id: json["id"] ?? '',
        groupId: json["group_id"] ?? '',
        teacherSubjectId: json["teacher_subject_id"] ?? '',
        createdDate: json["created_date"] ?? '',
      );
}

List<MySubjectOverall> listMySubjectOverall(String str) =>
    List<MySubjectOverall>.from(
        json.decode(str).map((x) => MySubjectOverall.fromJson(x)));

class MySubjectOverall {
  final MySubject subject;
  final MyTeacherSubject teacherSubject;
  final MyGroupSubject groupSubject;
  MySubjectOverall({
    required this.subject,
    required this.teacherSubject,
    required this.groupSubject,
  });

  factory MySubjectOverall.fromJson(Map<String, dynamic> json) =>
      MySubjectOverall(
        subject: MySubject.fromJson(json["subject"]),
        teacherSubject: MyTeacherSubject.fromJson(json["teacher_subject"]),
        groupSubject: MyGroupSubject.fromJson(json["group_subject"]),
      );
}
