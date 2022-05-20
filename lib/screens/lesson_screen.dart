import 'package:flutter/material.dart';

import '../models/lesson_model.dart';
import '../widgets/video_player_widget.dart';

class LessonScreen extends StatelessWidget {
  final Lesson lesson;

  const LessonScreen({
    Key? key,
    required this.lesson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LessonContent(lesson: lesson);
  }
}
