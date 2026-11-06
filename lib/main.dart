

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/farm_details.dart';
import 'package:my_app/pages/farmer_details_page.dart';

void main(){
  return runApp(
    ProviderScope(
      child: MyApp(),
    )
  );
}


class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("MyAPP"),
        ),
        body: FarmerDetailsPage(),
      ),
    );
  }
}

