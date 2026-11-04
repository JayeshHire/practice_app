

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class FarmerDetailsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FarmerDetailsForm();
  }
}

class FarmerDetailsForm extends StatefulWidget {

  @override
  State<FarmerDetailsForm> createState() => _FarmerDetFormState() ;
}

class _FarmerDetFormState extends State<FarmerDetailsForm>{

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final educationController = TextEditingController();
  final familyController = TextEditingController();
  
  DateTime? _selectedDateTime ;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    addressController.dispose();
    educationController.dispose();
    familyController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context, 
      initialDate: _selectedDateTime?? DateTime.now(),
      firstDate: DateTime(1990), 
      lastDate: DateTime.now()
    );
    
    if (date == null) return ;

    final TimeOfDay? time = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime?? DateTime.now()) 
    );

    if (time == null) return ;

    setState(() {
      _selectedDateTime = 
      DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your name'
                  ),
                ),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter address details'
                  ),
                ),
                TextFormField(
                  controller: educationController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter education details'
                  ),
                ),
                TextFormField(
                  controller: familyController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter family background details'
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDateTime != null? "$_selectedDateTime": "${DateTime.now()}"
                    ),
                    InkWell(
                      onTap: () async {
                        await _pickDateTime(context);
                      },
                      child: Icon(
                        Icons.calendar_month
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: FloatingActionButton(
                    onPressed: () {
                      print("name: ${nameController.text}");
                      print("address: ${addressController.text}");
                      print("education: ${educationController.text}");
                      print("family background: ${familyController.text}");
                      // print("")
                    },
                    child: Icon(Icons.info),
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}