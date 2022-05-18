
import 'dart:convert';

List<Lesson> listLessonsFromJson(String str) =>
    List<Lesson>.from(json.decode(str).map((x) => Lesson.fromJson(x)));

Lesson oneLessonFromJson(String str) =>
    Lesson.fromJson(json.decode(str));

class Lesson {
  String id;
  String name;
  String description;
  String videoFileUrl;
  String documentFileUrl;
  String groupSubjectId;
  String createdDate;

  Lesson({
    required this.id,
    required this.name,
    required this.description,
    required this.videoFileUrl,
    required this.documentFileUrl,
    required this.groupSubjectId,
    required this.createdDate,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) =>
      Lesson(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        videoFileUrl: json["video_file_url"],
        documentFileUrl: json["document_file_url"],
        groupSubjectId: json["group_subject_id"],
        createdDate: json["created_date"],
      );
}
