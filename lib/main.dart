import 'package:flutter/material.dart';
import 'package:my_app/component.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const VideoApp());

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset(
            "assets/earth.avi"
          )
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: InkWell(
            onDoubleTap: () {
              // Duration currentDuration = _controller.value.position ;
              // currentDuration += Duration(seconds: 10);
              // _controller.seekTo(currentDuration);
              // setState(() {
              // });
            },
            onTap: () {
              // print("Single tap on the widget");
            },
            onLongPress: () {
              // print("Widget is pressed for long time");
            },
            child: Container(
              height: 230,
              color: Colors.black,
              // width: 400,
              child: Stack(
                children: [
                  _controller.value.isInitialized
                  ? Center(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  )
                  : Container(),
                  VideoControlsVisibilityWidget(controller: _controller)
                ],
              )
            ),
          )
        ),
        
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying ? _controller.pause() : _controller.play();
            });
          },
          child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}