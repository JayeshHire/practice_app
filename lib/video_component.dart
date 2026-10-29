
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_app/fullscreen.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter/services.dart';


void enterFullScreen() {
  // Hide top status bar and bottom navigation bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  
  // Force landscape orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

void exitFullScreen() {
  // Restore system bars
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  
  // Restore all orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
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
                  MaterialPageRoute(builder: (_) => FullscreenWiget(_controller))
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
                  VideoControlsVisibilityWidget(controller: _controller, isFullScreen: false)
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

class VideoControlsVisibilityWidget extends StatefulWidget {


  VideoControlsVisibilityWidget({super.key, required this.controller, required this.isFullScreen}) ;

  VideoPlayerController controller ;
  bool isFullScreen ; 

  @override
  VideoControlsVisibilityStateWidget createState() => VideoControlsVisibilityStateWidget() ;
}


class VideoControlsVisibilityStateWidget extends State<VideoControlsVisibilityWidget>{
  bool _isVisible = false;

  Timer? _timer ;

  void _showWidgetTemporarily(){

    _timer?.cancel();

    setState(() {
      _isVisible = true;
    });

    _timer = Timer(const Duration(seconds: 5), () {
      if (mounted){
        setState(() {
          _isVisible = false ;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: (){
                  _showWidgetTemporarily();
                },
                onDoubleTap: (){
                  Duration currentDuration = widget.controller.value.position ;
                  currentDuration -= Duration(seconds: 10);
                  widget.controller.seekTo(currentDuration);
                  setState(() {
                  });
                },
                onLongPress: (){
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: (){
                  _showWidgetTemporarily();
                },
                onDoubleTap: (){
                  Duration currentDuration = widget.controller.value.position ;
                  currentDuration += Duration(seconds: 10);
                  widget.controller.seekTo(currentDuration);
                  setState(() {
                  });
                },
                onLongPress: (){
                },
              ),
            ),
          ],
        ),
        Visibility(
        visible: _isVisible,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: Stack(
          children: [
              Align(
                  alignment: Alignment.bottomCenter,
                  child: 
                  // Padding(
                    // padding: const EdgeInsets.fromLTRB(5, 10, 5, 500),
                    // child: 
                    Positioned(
                      top: 10,
                      width: double.infinity,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 25),
                        child: VideoProgressIndicator(
                          widget.controller,
                          allowScrubbing: true,
                        ),
                      )
                    )
              ),
              Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Positioned(
                      top: 10,
                      right: 10,
                      left: 10,
                      child: Icon(
                        Icons.closed_caption,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      // right: 10,
                      bottom: 10,
                      child: Icon(
                        Icons.speed,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      bottom: 10,
                      right: 10,
                      child: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    )
                  ],
                )
              ),
              Center(
                child: Positioned(
                  top: 10,
                  bottom: 10,
                  right: 10,
                  left: 10,
                  child: InkWell(
                    onTap: () {
                      widget.controller.value.isPlaying? widget.controller.pause(): widget.controller.play();
                      setState(() {
                        
                      });
                    },
                    child: Icon(
                      widget.controller.value.isPlaying? Icons.pause: Icons.play_arrow ,
                      color: Colors.white,
                    ),
                  ),
                )
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    child: Icon(
                      widget.isFullScreen ? Icons.fullscreen_exit: Icons.fullscreen ,
                      color: Colors.white,
                    ),
                    onTap: () {
                      if (widget.isFullScreen){
                        exitFullScreen();
                        Navigator.pop(context);
                      } else {
                        enterFullScreen();
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (_) => FullscreenWiget(widget.controller))
                          );
                      }
                    },
                  ),
                ),
              )
            ],
          )
        ),
        ],
      ),
    );
  }
}