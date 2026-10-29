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

