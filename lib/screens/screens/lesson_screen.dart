import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../widgets/widgets.dart';

class LessonScreen extends StatelessWidget {
  final Lesson lesson;
  final bool isTeacher;

  const LessonScreen({
    Key? key,
    required this.isTeacher,
    required this.lesson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollViewWidget(lesson: lesson),
    );
  }
}
