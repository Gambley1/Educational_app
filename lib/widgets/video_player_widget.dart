import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../models/lesson_model.dart';

class Home extends StatefulWidget{
  final Lesson group;
  const Home({Key? key, required this.group}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late VideoPlayerController controller;

  @override
  void initState() {
    loadVideoPlayer();
    super.initState();
  }

  loadVideoPlayer(){
    controller = VideoPlayerController.network("https://storage.googleapis.com/silent-turbine-304510.appspot.com/n50-files/45a221be-100a-4047-8fe5-87e7b6bb8041_main.mp4");
    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value){
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(widget.group.name),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
          child: Column(
              children:[
                AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),

                Container( //duration of video
                  child: Text("Total Duration: " + controller.value.duration.toString()),
                ),

                Container(
                    child: VideoProgressIndicator(
                        controller,
                        allowScrubbing: true,
                        colors:const VideoProgressColors(
                          backgroundColor: Colors.redAccent,
                          playedColor: Colors.green,
                          bufferedColor: Colors.purple,
                        )
                    )
                ),

                Container(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: (){
                            if(controller.value.isPlaying){
                              controller.pause();
                            }else{
                              controller.play();
                            }

                            setState(() {

                            });
                          },
                          icon:Icon(controller.value.isPlaying?Icons.pause:Icons.play_arrow)
                      ),

                      IconButton(
                          onPressed: (){
                            controller.seekTo(Duration(seconds: 0));

                            setState(() {

                            });
                          },
                          icon:Icon(Icons.stop)
                      )
                    ],
                  ),
                )
              ]
          )
      ),
    );
  }
}