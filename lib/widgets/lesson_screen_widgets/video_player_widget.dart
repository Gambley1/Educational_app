import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../models/models.dart';



class VideoPlayerWidget extends StatefulWidget {
  final Lesson lesson;
  const VideoPlayerWidget({
    Key? key,
    required this.lesson,
  }) : super(key: key);
  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
                      text: widget.lesson.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              centerTitle: false,
            ),
          ),
          SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return VideoPlayerView(lesson: widget.lesson);
                },
                childCount: 1,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.6,
              ))
        ],
      ),
    );
  }
}

class VideoPlayerView extends StatefulWidget {
  final Lesson lesson;

  const VideoPlayerView({
    Key? key,
    required this.lesson,
  }) : super(key: key);

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController controller;

  @override
  void initState() {
    loadVideoPlayer();
    super.initState();
  }

  Future loadVideoPlayer() async {
    controller = VideoPlayerController.network(widget.lesson.videoFileUrl);
    controller.addListener(() {
      mounted ? setState(() {}) : '';
    });
    controller.initialize().then((value) {
      mounted ? setState(() {}) : '';
    });
  }

  @override
  void dispose() {
    controller.pause();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
        Text("Total Duration: " + controller.value.duration.toString()),
        VideoProgressIndicator(
          controller,
          allowScrubbing: true,
          colors: VideoProgressColors(
            backgroundColor: Colors.grey,
            playedColor: const Color.fromARGB(255, 255, 0, 0),
            bufferedColor: Colors.white.withOpacity(.77),
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                if (controller.value.isPlaying) {
                  controller.pause();
                } else {
                  controller.play();
                }

                setState(() {});
              },
              icon: Icon(
                  controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
            ),
            IconButton(
              onPressed: () {
                controller.seekTo(
                  const Duration(seconds: 0),
                );
                setState(() {});
              },
              icon: const Icon(Icons.stop),
            ),
          ],
        )
      ],
    );
  }
}
