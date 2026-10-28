

import 'package:flutter/material.dart';

void main(){
  return runApp(App());
}


class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(child: HomePage()),
      ),
    );
  }
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (_) => SecondPage())
              );
          }, 
          icon: Icon(
            Icons.arrow_forward
          )
        ),
        Text("My Home page"),
      ],
    );
  }
}


class SecondPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            IconButton(onPressed: () {
              Navigator.pop(context);
            }, 
            icon: Icon(
              Icons.arrow_back
            )
            ),
            Text(
              "This is the second page"
            )
          ],
        ),
      ),
    );
  }
}