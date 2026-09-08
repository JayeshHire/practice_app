

import 'package:flutter/material.dart';
import 'package:my_app/main.dart';

class GuestInfoWidget extends StatefulWidget {

  String imgSource;
  String name;
  String price;
  OrderState orderState ;

  GuestInfoWidget(this.imgSource, this.name, this.price, this.orderState);
  
  @override
  _GuestInfoWidgetState createState() => _GuestInfoWidgetState();
}

class _GuestInfoWidgetState extends State<GuestInfoWidget> {
  bool isOrdered = false;

  // load the state at initState and store the state before destroy

  void loadOrderState(){
    setState(() {
      isOrdered = widget.orderState.isOrdered;
    });
  }

  void persistOrderState(){
    widget.orderState.isOrdered = isOrdered ;
  }

  @override  
  void initState(){
    super.initState();
    loadOrderState();
  }

  @override  
  void dispose(){
    persistOrderState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Center(
      child: SizedBox(
        width: 400,
        child: Card(
          child: Column(
            children: <Widget>[
              Image.asset(
                widget.imgSource,
                height: 200,
                width: double.infinity,
                fit: BoxFit.contain,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title: Text("${widget.name}"),
                      subtitle: Text("${widget.price}"),
                      tileColor: Colors.amber,
                    )
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: switch(isOrdered){
                          true => Color(0xFF450C3F),
                          _ => Color(0xFFFFF5F5)
                        },
                        foregroundColor: switch(isOrdered) {
                          true => Color(0xFFD9EFBD),
                          _ => Color(0xFF4A4A4A)
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.zero,
                            topRight: Radius.zero,
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)
                          )
                        )
                      ),
                      onPressed: () {
                        setState(() {
                          isOrdered = !isOrdered ;
                        });
                      },
                      child: switch(isOrdered){
                        true => Text(
                          "Ordered",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        _ => Text(
                          "order now",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        )
                      },
                    ),
                  )
                ]
              )
            ],
          ),
        )
      )
    );
  }
}