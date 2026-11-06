import 'package:flutter/material.dart';
import 'package:my_app/pages/farmer_prop_det_page.dart';

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
  final careerInceptionDateController = TextEditingController();
  
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

    setState(() {
      _selectedDateTime = 
      DateTime(
        date.year,
        date.month,
        date.day
      );
      careerInceptionDateController.text = "${_selectedDateTime?.day}/${_selectedDateTime?.month}/${_selectedDateTime?.year}" ;
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
                TextFormField(
                  controller: careerInceptionDateController,
                  readOnly: true, 
                  onTap: () async {
                    await _pickDateTime(context); 
                  },
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Enter the career inception date',
                    suffixIcon: IconButton( 
                      icon: const Icon(Icons.calendar_month),
                      onPressed: () async {
                        await _pickDateTime(context); 
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: FloatingActionButton(
                    onPressed: () {
                      print("name: ${nameController.text}");
                      print("address: ${addressController.text}");
                      print("education: ${educationController.text}");
                      print("family background: ${familyController.text}");
                      print("career inception date: ${careerInceptionDateController.text}");
                      
                      // print("")
                    },
                    child: Icon(Icons.info),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context){
                            return FarmPropertiesDetailsPage();
                          }
                        )
                      );
                    },
                    child: Icon(Icons.arrow_forward),
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
