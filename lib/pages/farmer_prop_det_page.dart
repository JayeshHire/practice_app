

import 'package:flutter/material.dart';
import 'package:my_app/pages/drawdown_labels.dart';

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
            FloatingActionButton(
              onPressed: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context){
                      return FarmPropertyDetailsFormPage();
                    }
                  )
                );
              },
              child: Icon(
                Icons.add
              ),
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

class FarmPropertyDetailsFormPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final farmlandAreaController = TextEditingController();
    final areaUnitController = TextEditingController();
    final locationController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: farmlandAreaController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Area of farm land'
              ),
            ),
            // Area unit
            DropdownMenu<AreaUnitLable>(
              controller: areaUnitController,
              requestFocusOnTap: true,
              label: const Text("Select Area"),
              onSelected: (AreaUnitLable){
                print("Area selected is ${AreaUnitLable!.label}");
              },
              dropdownMenuEntries: AreaUnitLable.entries
            ),
            // location
            TextFormField(
              controller: locationController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Location of farm land'
              ),
            )
          ],
        ),
      ),
    );
  }
}