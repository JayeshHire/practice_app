

import 'package:flutter/material.dart';

class FarmPropertiesDetailsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "Farm Properties Details page"
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back
              ),
            )
          ],
        )
      )
    );
  }
}