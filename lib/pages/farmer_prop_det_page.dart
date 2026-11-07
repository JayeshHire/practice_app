

import 'package:flutter/material.dart';

class FarmPropertiesDetailsFormPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fill the form properties details"),
      ),
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