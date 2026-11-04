

import 'package:flutter/material.dart';

@immutable
class Farmer {
  Farmer({
    required this.name,
    required this.Address,
    required this.education,
    required this.familyBackground,
    required this.careerInceptionDatetime,
    required this.careerSpan
  });

  factory Farmer.initialize(){
    return Farmer(
      name: "", 
      Address: "", 
      education: "", 
      familyBackground: "", 
      careerInceptionDatetime: DateTime(1990), 
      careerSpan: Duration(minutes: 0)
      );
  }

  factory Farmer.copyWith(
    Farmer farmer,
    String? name,
    String? Address,
    String? education,
    String? familyBackground,
    DateTime? careerInceptionDatetime,
    Duration? careerSpan
  ){
    return Farmer(
      name: name?? farmer.name, 
      Address: Address?? farmer.Address, 
      education: education?? farmer.education , 
      familyBackground: familyBackground?? farmer.familyBackground, 
      careerInceptionDatetime: careerInceptionDatetime?? farmer.careerInceptionDatetime, 
      careerSpan: careerSpan?? farmer.careerSpan
      );
  }

  final String name;
  final String Address;
  final String education;
  final String familyBackground;
  final DateTime careerInceptionDatetime;
  final Duration careerSpan ;

}

@immutable 
class FarmPropertiesDetail {
  
  final int noFarmProperties ;
  final List<FarmProperty> farmProperties ;
}

@immutable 
class FarmProperty {

  final double farmlandArea ;
  final String location ;
}

enum CropLifecycleStage {
  not_planted,
  planted_but_not_harvested,
  harvested
}

enum WeightUnit {
  gm,
  kg,
  quintal,
  ton
}

enum AreaUnit {
  sq_m,
  sq_ft,
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

  CropDetails({
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
      lifecycleStage: CropLifecycleStage.not_planted, 
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
}

enum IncomeCalcPeriod {
  yearly,
  half_yearly,
  quaterly,
  monthly
}

@immutable
class AlliedBusiness {

  AlliedBusiness({
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
}

