import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'menu_info.dart';

void main() {
  runApp(const MyApp());
}

class FoodItem {
  String name;
  String price;
  String imageSource;

  FoodItem({required this.name, required this.price, required this.imageSource});

  factory FoodItem.fromJson(Map<String, dynamic> json){
    return FoodItem(
      name: json["name"] as String, 
      price: json["price"] as String, 
      imageSource: json["imageSource"] as String
      );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Saving state',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Order your favourite meal 😋😋'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class OrderState {
  bool isOrdered ;
  int idx;

  OrderState(this.isOrdered, this.idx);
}

class _MyHomePageState extends State<MyHomePage> {

  List<FoodItem> menu = [] ;

  List<OrderState> orderStateStore = [];

  Future<void> loadJson() async {
    final String response = await rootBundle.loadString('assets/menu.json');

    final List<dynamic> data = jsonDecode(response);

    for (dynamic d in data){
      FoodItem m = FoodItem.fromJson(d);
      menu.add(m);
    }
  }

  @override  
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder<void>(
        future: loadJson(), 
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError){
            return Center(child: Text("Error: ${snapshot.error}"),);
          }

          for (int i = 0; i < menu.length ; i++){
            orderStateStore.add(
              OrderState(false, i)
            );
          }
          return Center(
            child: ListView(
              children: <Widget>[
                for (int i = 0; i < menu.length ; i++)
                MenuInfoWidget(menu[i].imageSource, menu[i].name, '\$ ${menu[i].price}', orderStateStore[i]),
              ],
            ),
          );
        }
        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
