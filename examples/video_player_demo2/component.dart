
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoControlsVisibilityWidget extends StatefulWidget {


  VideoControlsVisibilityWidget({super.key, required this.controller}) ;

  VideoPlayerController controller ;

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
                      child: VideoProgressIndicator(
                        widget.controller,
                        allowScrubbing: true,
                      ),
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
            ],
          )
        ),
        ],
      ),
    );
  }
}