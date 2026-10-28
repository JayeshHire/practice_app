import 'package:flutter/material.dart';
import 'package:my_app/fullscreen.dart';
import 'video_component.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
          children: [
              VideoApp()
          ],
        ),
        )
      ),
    );
  }
}

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
    return Container(
      child: Column(
        children: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (_) => FullscreenWiget())
                );
              }, 
              icon: Icon(
                Icons.arrow_forward
          )),
          Center(
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
        ],
      )
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}