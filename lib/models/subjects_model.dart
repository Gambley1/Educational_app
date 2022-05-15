import 'package:educational_app/models/data_model.dart';

class Subject {
  String thumbnail;
  String name;

  Subject({
    required this.name,
    required this.thumbnail,
  });
}

late List<Datum>? data;

List<Subject> subjectList = [
  Subject(
    name: 'Алгебра',
    thumbnail: 'assets/icons/algebra.png',
  ),
  Subject(
    name: 'Геометрия',
    thumbnail: 'assets/icons/geometry.png',
  ),
  Subject(
    name: 'Геометрия',
    thumbnail: 'assets/icons/geometry.png',
  ),
  Subject(
    name: 'Геометрия',
    thumbnail: 'assets/icons/geometry.png',
  ),
  Subject(
    name: 'Геометрия',
    thumbnail: 'assets/icons/geometry.png',
  ),
  Subject(
    name: 'Геометрия',
    thumbnail: 'assets/icons/geometry.png',
  ),
];
