import 'package:flutter/material.dart';

import '../models/group_model.dart';

class LessonScreen extends StatelessWidget {
  final Group group;
  const LessonScreen({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text(group.name),
      ),
    );
  }
}
