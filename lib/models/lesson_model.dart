class Lesson {
  String name;
  String duration;

  Lesson({
    required this.duration,
    required this.name,
  });
}

List<Lesson> lessonList = [
  Lesson(
    duration: '11 min 20 sec',
    name: "Why Flutter Development",
  ),
  Lesson(
    duration: '10 min 11 sec',
    name: "Setup Flutter on MacOS",
  ),
  Lesson(
    duration: '7 min',
    name: "Setup Flutter on Windows",
  ),
  Lesson(
    duration: '5 min',
    name: "Introduction to Flutter widgets.",
  ),
  Lesson(
    duration: '5 min',
    name: "What are Stateless Widgets?",
  ),
  Lesson(
    duration: '5 min',
    name: "What are Statefull Widgets?",
  )
];