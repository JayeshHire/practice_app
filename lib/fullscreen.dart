

import 'package:flutter/material.dart';

class FullscreenWiget extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Column(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            }, 
            icon: Icon(
              Icons.arrow_back
            )
          ),
          Text(
            "Fullscreen Widget"
          )
        ],
      ),
      )
    );
  }
}