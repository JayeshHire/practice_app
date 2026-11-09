import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/farm_details.dart';
import 'package:my_app/models/m_utils.dart';
import 'package:my_app/models/session.dart';

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

  CropDetails copyWith(
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

  CropDetails fromMap(Map<String, dynamic> mp){
    return CropDetails(
      name: mp["name"], 
      plantationDate: mp["plantationDate"], 
      harvestDate: mp["harvestDate"], 
      lifecycleStage: mp["lifecycleStage"], 
      yieldQuantity: mp["yieldQuantity"], 
      weightUnit: mp["weightUnit"], 
      plantationArea: mp["plantationArea"], 
      areaUnit: mp["areaUnit"], 
      costAccrued: mp["costAccrued"], 
      labourCost: mp["labourCost"], 
      farmServicesCost: mp["farmServicesCost"], 
      fertilizerCost: mp["fertilizerCost"], 
      pesticideCost: mp["pesticideCost"], 
      plantationMaterialCost: mp["plantationMaterialCost"], 
      plantationMaterialType: mp["plantationMaterialType"]);
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
  String? formId;
}

class CropDetailsNotifier extends Notifier<CropDetails>{

  @override
  CropDetails build() {
    return CropDetails.initialize();
  }

  void setFormId(){
    final myForm = ref.watch(myFormNotifierProvider);
    state.formId = myForm.formId ;
  }
}

final cropDetailsNotifierProvider = NotifierProvider<CropDetailsNotifier, CropDetails>(
  (){
    final notifier = CropDetailsNotifier();
    notifier.setFormId();
    return notifier;
  }
);
