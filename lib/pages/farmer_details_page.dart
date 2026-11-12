import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/farm_details.dart';
import 'package:my_app/pages/farmer_prop_det_page.dart';

class FarmerDetailsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter farmer details"),
      ),
      body: FarmerDetailsForm(),
    );
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

    
    return Consumer(
      builder: (context, ref, _) {
        final farmer = ref.watch(farmerProvider) ;
        return Padding(
          padding: EdgeInsets.all(15),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(
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
                          onPressed: () async {
                            print("name: ${nameController.text}");
                            print("address: ${addressController.text}");
                            print("education: ${educationController.text}");
                            print("family background: ${familyController.text}");
                            print("career inception date: ${careerInceptionDateController.text}");
                            await ref.read(farmerProvider.notifier).save(
                              nameController.text, 
                              addressController.text, 
                              educationController.text, 
                              familyController.text, 
                              _selectedDateTime, 
                              _selectedDateTime == null ? Duration(days: 0): DateTime.now().difference(_selectedDateTime!)
                            );

                            nameController.text = "" ;
                            addressController.text = "" ;
                            educationController.text = "" ;
                            familyController.text = "";
                            careerInceptionDateController.text = "";
                            _selectedDateTime = DateTime.now();
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
                                  return FarmPropertiesDetailsFormPage();
                                }
                              )
                            );
                          },
                          child: Icon(Icons.arrow_forward),
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
                                  return FarmerDetailsInfo();
                                }
                              )
                            );
                          },
                          child: Icon(Icons.account_circle_rounded),
                        ),
                      )
                    ],
                  ),
              ),
            )
          ),
        );
      },
    );
  }
}

class FarmerDetailsInfo extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Entered Farmers Information"),),
      body: SafeArea(
        child: FutureBuilder<List<Farmer>>(
          future: ref.read(farmerProvider.notifier).getFarmers(),
          builder: (context, snapshot){
            if (snapshot.hasError){
              return Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(
                  color: Colors.red
                ),
              );
            }
            
            if (snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFA0E0EF),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData){
              List<Farmer> farmers = snapshot.data! ;
              return ListView.builder(
                itemCount: farmers.length,
                itemBuilder: (context, index){
                  return TextButton(
                    onPressed: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) {
                            return SingleFarmerProfilePage(farmers[index]);
                          }
                        )
                      );
                    }, 
                    child: Text("${farmers[index].name}")
                  );
                },
              );
            }

            return Text("Unknown Error") ;
          }
        ),
      ),
    );
  }
}

class SingleFarmerProfilePage extends StatelessWidget {

  SingleFarmerProfilePage(this.farmer);

  final Farmer farmer;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Text("Name"),
                Text(": "),
                Text("${farmer.name}")
              ],
            ),
            Row(
              children: [
                Text("address"),
                Text(": "),
                Text("${farmer.address}")
              ],
            ),
            Row(
              children: [
                Text("education"),
                Text(": "),
                Text("${farmer.education}")
              ],
            ),
            Row(
              children: [
                Text("family background"),
                Text(": "),
                Text("${farmer.familyBackground}")
              ],
            ),
            Row(
              children: [
                Text("career inception date"),
                Text(": "),
                Text("${farmer.careerInceptionDatetime}")
              ],
            ),
            Row(
              children: [
                Text("career span"),
                Text(": "),
                Text("${farmer.careerSpan}")
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
              ),
            )
          ],
        ),
      ),
    );
  }
}