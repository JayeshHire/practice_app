

import 'package:flutter/material.dart';
import 'package:my_app/video_component.dart';
import 'package:video_player/video_player.dart';

class FullscreenWiget extends StatelessWidget {

  FullscreenWiget(this.controller, {super.key});

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: VideoAppFullscreen(controller)
    );
  }
}


/// Stateful widget to fetch and then display video content.
class VideoAppFullscreen extends StatefulWidget {
  VideoAppFullscreen(this.controller, {super.key});

  VideoPlayerController controller ;

  @override
  _VideoAppFullscreenState createState() => _VideoAppFullscreenState();
}

class _VideoAppFullscreenState extends State<VideoAppFullscreen> {
  // late VideoPlayerController _controller;

  @override
  // void initState() {
  //   super.initState();
  //   _controller =
  //       VideoPlayerController.asset(
  //           "assets/earth.avi"
  //         )
  //         ..initialize().then((_) {
  //           // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
  //           setState(() {});
  //         });
  // }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return ;

        exitFullScreen() ;
        Navigator.pop(context);
      },
      child: widget.controller.value.isInitialized
      ? Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: AspectRatio(
            aspectRatio: widget.controller.value.aspectRatio,
            child: Stack(
              children: [
                // FittedBox(
                  // fit: BoxFit.contain,
                  // child: SizedBox(
                    // width: _controller.value.size.width,
                    // height: _controller.value.size.height,
                    // child: 
                    VideoPlayer(widget.controller),
                  // ),
                // ),
                Positioned.fill(
                  child: VideoControlsVisibilityWidget(
                    controller: widget.controller, 
                    isFullScreen: true
                  ),
                )
              ],
            )
          ),
        ),
      )
      : const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}