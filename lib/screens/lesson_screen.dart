import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../models/group_model.dart';
import '../models/lesson_model.dart';
import '../widgets/video_player_widget.dart';

class LessonScreen extends StatelessWidget {
  final Lesson group;

  const LessonScreen({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(group: group,),
    );
  }
}
