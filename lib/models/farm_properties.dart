import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/farm_details.dart';
import 'package:my_app/models/m_utils.dart';
import 'package:my_app/models/session.dart';

@immutable 
class FarmPropertiesDetail {
  
  FarmPropertiesDetail(
    this.noFarmProperties,
    this.farmProperties);

  factory FarmPropertiesDetail.initialize(){
    return FarmPropertiesDetail(
      0, 
      [],
      // formId: formId
    );
  }

  FarmPropertiesDetail copyWith(
    FarmPropertiesDetail farmPropertiesDetail,
    int? noFarmProperties,
    List<FarmProperty>? farmProperties,
    // String formId
  ){
    return FarmPropertiesDetail(
      noFarmProperties?? farmPropertiesDetail.noFarmProperties, 
      farmProperties?? farmPropertiesDetail.farmProperties,
      // formId: formId
    );
  }

  final int noFarmProperties ;
  final List<FarmProperty> farmProperties ;
  String? formId;
}

@immutable 
class FarmProperty {

  FarmProperty({
    required this.farmlandArea,
    required this.areaUnit,
    required this.location,
  });

  factory FarmProperty.initialize(){
    return FarmProperty(
      farmlandArea: 0, 
      areaUnit: AreaUnit.acre, 
      location: "",
      // formId: formId
    );
  }

  FarmProperty copyWith(
    FarmProperty farmProperty,
    double? farmlandArea,
    AreaUnit? areaUnit,
    String? location,
    // String formId
  ){
    return FarmProperty(
      farmlandArea: farmlandArea?? farmProperty.farmlandArea, 
      areaUnit: areaUnit?? farmProperty.areaUnit, 
      location: location?? farmProperty.location,
      // formId: formId
    );
  }

  final double farmlandArea ;
  final AreaUnit areaUnit;
  final String location ;
  String? formId;
}

class FarmPropertyNotifier extends Notifier<FarmProperty>{

  @override
  FarmProperty build() {
    final myForm = ref.watch(myFormNotifierProvider);
    return FarmProperty.initialize()..formId = myForm.formId;
  }
}

final farmProNotifierProvider = NotifierProvider<FarmPropertyNotifier, FarmProperty>(
  FarmPropertyNotifier.new,
);


class FarmPropertiesNotifier extends Notifier<FarmPropertiesDetail> {

  @override
  FarmPropertiesDetail build() {
    final myForm = ref.watch(myFormNotifierProvider);
    return FarmPropertiesDetail.initialize()..formId = myForm.formId;
  }
}

final farmProDtlNotifierProvider = NotifierProvider<FarmPropertiesNotifier, FarmPropertiesDetail>(
  FarmPropertiesNotifier.new,
);