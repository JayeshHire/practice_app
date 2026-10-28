

import 'package:flutter/material.dart';
import 'package:my_app/video_component.dart';
import 'package:video_player/video_player.dart';

class FullscreenWiget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: VideoAppFullscreen()
    );
  }
}


/// Stateful widget to fetch and then display video content.
class VideoAppFullscreen extends StatefulWidget {
  const VideoAppFullscreen({super.key});

  @override
  _VideoAppFullscreenState createState() => _VideoAppFullscreenState();
}

class _VideoAppFullscreenState extends State<VideoAppFullscreen> {
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
    return FittedBox(
              fit: BoxFit.cover,
              // width: 400,
              child: Stack(
                children: [
                  _controller.value.isInitialized
                  ? Center(
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    )
                  )
                  : Container(),
                  VideoControlsVisibilityWidget(controller: _controller, isFullScreen: true)
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