import 'package:educational_app/models/data_model.dart';
import 'package:flutter/material.dart';

class LessonScreen extends StatelessWidget {
  final Datum data;
  const LessonScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text(data.name!),
      ),
    );
  }
}
