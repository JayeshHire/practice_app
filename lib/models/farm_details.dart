

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_app/models/session.dart';
import 'package:uuid/enums.dart';

@immutable
class Farmer {
  Farmer({
    required this.name,
    required this.address,
    required this.education,
    required this.familyBackground,
    required this.careerInceptionDatetime,
    required this.careerSpan,
  });

  factory Farmer.initialize(){
    return Farmer(
      name: "", 
      address: "", 
      education: "", 
      familyBackground: "", 
      careerInceptionDatetime: DateTime(1990), 
      careerSpan: Duration(minutes: 0)
      );
  }

  Farmer copyWith({
    String? name,
    String? address,
    String? education,
    String? familyBackground,
    DateTime? careerInceptionDatetime,
    Duration? careerSpan
  }){
    return Farmer(
      name: name?? this.name, 
      address: address?? this.address, 
      education: education?? this.education , 
      familyBackground: familyBackground?? this.familyBackground, 
      careerInceptionDatetime: careerInceptionDatetime?? this.careerInceptionDatetime, 
      careerSpan: careerSpan?? this.careerSpan
      );
  }

  static Duration toDuration(String dStr){
    List<String> lstr = dStr.split(":");
    int hours =  int.parse(lstr[0]);
    int mins = int.parse(lstr[1]);
    int secs = int.parse(lstr[2].split(".")[0]);
    int ms = int.parse(lstr[2].split(".")[0]);
    return Duration(
      hours: hours, 
      minutes: mins,
      seconds: secs,
      milliseconds: ms
    );
  }

  static Farmer fromMap(Map<String, dynamic> data){
    return Farmer(
      name: data["name"], 
      address: data["address"], 
      education: data["education"], 
      familyBackground: data["family_background"], 
      careerInceptionDatetime: DateTime.parse(data["career_inception_date"]), 
      careerSpan: Farmer.toDuration(data["career_span"])
    );
  }

  final String name;
  final String address;
  final String education;
  final String familyBackground;
  final DateTime careerInceptionDatetime;
  final Duration careerSpan ;
  String? formId;

}

class FarmerNotifier extends Notifier<Farmer> {

  @override
  Farmer build() {
    final form = ref.watch(myFormNotifierProvider);
    return Farmer.initialize()..formId = form.formId;
  }

  Future<void> save(
    String? name,
    String? address,
    String? education,
    String? familyBackground,
    DateTime? careerInceptionDatetime,
    Duration? careerSpan
  ) async {
    

    // state = state.copyWith(
    //   name?? state.name,
    //   address?? state.address,
    //   education?? state.education,
    //   familyBackground?? state.familyBackground,
    //   careerInceptionDatetime?? state.careerInceptionDatetime,
    //   careerSpan?? state.careerSpan
    // );

    print("Inside save");

    print(careerInceptionDatetime);
    await supabase.from('farmer_dtl').insert({
      'name': name?? state.name,
      'address': address?? state.address,
      'education': education?? state.education,
      'family_background': familyBackground?? state.familyBackground,
      'career_inception_date': careerInceptionDatetime.toString()?? state.careerInceptionDatetime.toString(),
      'career_span': careerSpan.toString()?? state.careerSpan.toString()
    });

    state = Farmer.initialize();
    print("Saved the farmer data to the table in the supabase");
  }

  Future<List<Farmer>> getFarmers() async {

    final data = await supabase.from("farmer_dtl").select();
    List<Farmer> farmers = [];

    for (Map<String, dynamic> mp in data){
      farmers.add(
        Farmer.fromMap(mp)
      );
    }
    return farmers;
  }

  Future<Farmer> getFarmerById(int farmerId) async {

    final data = await supabase.from("farmer_dtl")
    .select()
    .eq('id', farmerId)
    .single();

    return Farmer.fromMap(data);
  }

  Future<Farmer> getNewFarmer() async {
    final f = Farmer.initialize();
    Future.delayed(Duration(seconds: 2));
    return f.copyWith(name: "Unknown");
  }

}

final farmerProvider = NotifierProvider<FarmerNotifier, Farmer>(
  FarmerNotifier.new,
);

