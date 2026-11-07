

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@immutable
class Farmer {
  const Farmer({
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

  Farmer copyWith(
    String? name,
    String? address,
    String? education,
    String? familyBackground,
    DateTime? careerInceptionDatetime,
    Duration? careerSpan
  ){
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

  static Farmer fromJson(Map<String, dynamic> data){
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
  final String formId;

}

class FarmerNotifier extends Notifier<Farmer> {

  @override
  Farmer build() {
    return Farmer.initialize();
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
        Farmer.fromJson(mp)
      );
    }
    return farmers;
  }
}

final farmerProvider = NotifierProvider<FarmerNotifier, Farmer>((){
  return FarmerNotifier();
});


enum CropLifecycleStage {
  notPlanted,
  plantedButNotHarvested,
  harvested
}

enum WeightUnit {
  gm,
  kg,
  quintal,
  ton
}

enum AreaUnit {
  sqM,
  sqFt,
  hectare,
  acre,
  guntha
}

enum PlantationMaterial {
  seeds,
  saplings,
  plants
}

@immutable 
class CropDetails {

  const CropDetails({
    required this.name,
    required this.plantationDate,
    required this.harvestDate,
    required this.lifecycleStage,
    required this.yieldQuantity,
    required this.weightUnit,
    required this.plantationArea,
    required this.areaUnit,
    required this.costAccrued,
    required this.labourCost,
    required this.farmServicesCost,
    required this.fertilizerCost,
    required this.pesticideCost,
    required this.plantationMaterialCost,
    required this.plantationMaterialType
  });

  factory CropDetails.initialize(){
    return CropDetails(
      name: "", 
      plantationDate: DateTime.now(), 
      harvestDate: DateTime.now(), 
      lifecycleStage: CropLifecycleStage.notPlanted, 
      yieldQuantity: 0, 
      weightUnit: WeightUnit.quintal, 
      plantationArea: 0, 
      areaUnit: AreaUnit.acre, 
      costAccrued: 0, 
      labourCost: 0, 
      farmServicesCost: 0, 
      fertilizerCost: 0, 
      pesticideCost: 0, 
      plantationMaterialCost: 0, 
      plantationMaterialType: PlantationMaterial.seeds
      );
  }

  factory CropDetails.copyWith(
    CropDetails cropDetails,
    String? name,
    DateTime? plantationDate,
    DateTime? harvestDate,
    CropLifecycleStage lifecycleStage,
    double? yieldQuantity,
    WeightUnit? weightUnit,
    double? plantationArea,
    AreaUnit? areaUnit,
    double? costAccrued,
    double? labourCost,
    double? fertilizerCost,
    double? pesticideCost,
    double? farmServicesCost,
    double? plantationMaterialCost,
    PlantationMaterial? plantationMaterialType
  ){
    return CropDetails(
      name: name?? cropDetails.name, 
      plantationDate: plantationDate?? cropDetails.plantationDate, 
      harvestDate: harvestDate?? cropDetails.harvestDate, 
      lifecycleStage: lifecycleStage?? cropDetails.lifecycleStage, 
      yieldQuantity: yieldQuantity?? cropDetails.yieldQuantity, 
      weightUnit: weightUnit?? cropDetails.weightUnit, 
      plantationArea: plantationArea?? cropDetails.plantationArea, 
      areaUnit: areaUnit?? cropDetails.areaUnit, 
      costAccrued: costAccrued?? cropDetails.costAccrued, 
      labourCost: labourCost?? cropDetails.labourCost, 
      farmServicesCost: farmServicesCost?? cropDetails.farmServicesCost, 
      fertilizerCost: fertilizerCost?? cropDetails.fertilizerCost, 
      pesticideCost: pesticideCost?? cropDetails.pesticideCost, 
      plantationMaterialCost: plantationMaterialCost?? cropDetails.plantationMaterialCost, 
      plantationMaterialType: plantationMaterialType?? cropDetails.plantationMaterialType
    );
  }

  final String name;
  final DateTime plantationDate;
  final DateTime harvestDate;
  final CropLifecycleStage lifecycleStage;
  final double yieldQuantity ;
  final WeightUnit weightUnit ;
  final double plantationArea;
  final AreaUnit areaUnit ;
  final double costAccrued;
  final double labourCost;
  final double fertilizerCost;
  final double pesticideCost;
  final double farmServicesCost;
  final double plantationMaterialCost;
  final PlantationMaterial plantationMaterialType ;
  final String formId;
}

enum IncomeCalcPeriod {
  yearly,
  halfYearly,
  quaterly,
  monthly
}

@immutable
class AlliedBusiness {

  const AlliedBusiness({
    required this.farmTools,
    required this.income,
    required this.incomeCalcPeriod,
    required this.name,
    required this.noOfBusinesses,
    required this.peopleEmployed
  });

  factory AlliedBusiness.initialize(){
    return AlliedBusiness(
      farmTools: [], 
      income: 0, 
      incomeCalcPeriod: IncomeCalcPeriod.yearly, 
      name: "", 
      noOfBusinesses: 0, 
      peopleEmployed: 0
    );
  }

  factory AlliedBusiness.copyWith(
    AlliedBusiness alliedBusiness,
    int? noOfBusinesses,
    String? name,
    double? income,
    IncomeCalcPeriod? incomeCalcPeriod,
    int? peopleEmployed,
    List<FarmTool>? farmTools,
  ){
    return AlliedBusiness(
      farmTools: farmTools?? alliedBusiness.farmTools, 
      income: income?? alliedBusiness.income, 
      incomeCalcPeriod: incomeCalcPeriod?? alliedBusiness.incomeCalcPeriod, 
      name: name?? alliedBusiness.name, 
      noOfBusinesses: noOfBusinesses?? alliedBusiness.noOfBusinesses, 
      peopleEmployed: peopleEmployed?? alliedBusiness.peopleEmployed
    );
  }
  
  final int noOfBusinesses;
  final String name;
  final double income;
  final IncomeCalcPeriod incomeCalcPeriod;
  final int peopleEmployed;
  final List<FarmTool> farmTools;
  final String formId;
}

class FarmTool {

  FarmTool({
    required this.name,
    required this.description
  });

  factory FarmTool.initialize(){
    return FarmTool(
      name: "", 
      description: ""
    );
  }

  factory FarmTool.copyWith(
    FarmTool farmtool,
    String? name,
    String? description
  ){
    return FarmTool(
      name: name?? farmtool.name, 
      description: description?? farmtool.description
    );
  }

  final String name;
  final String description;
  final String formId;
}

