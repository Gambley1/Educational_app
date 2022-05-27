import 'package:flutter/material.dart';

import '../../models/models.dart';
import 'video_player_widget.dart';

class CustomScrollViewWidget extends StatelessWidget {
  const CustomScrollViewWidget({
    Key? key,
    required this.lesson,
  }) : super(key: key);

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: lesson.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            centerTitle: false,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return VideoPlayerView(lesson: lesson);
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
