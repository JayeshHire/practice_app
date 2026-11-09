import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/farm_details.dart';
import 'package:my_app/models/m_utils.dart';
import 'package:my_app/models/session.dart';

@immutable
class AlliedBusiness {

  AlliedBusiness({
    required this.income,
    required this.incomeCalcPeriod,
    required this.name,
    required this.noOfBusinesses,
    required this.peopleEmployed
  });

  factory AlliedBusiness.initialize(){
    return AlliedBusiness(
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
  ){
    return AlliedBusiness(
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
  String? formId;
}

class AlliedBusinessNotifier extends Notifier<AlliedBusiness> {

  @override
  AlliedBusiness build() {
    return AlliedBusiness.initialize();
  }

  void setFormId(){
    final myForm = ref.watch(myFormNotifierProvider);
    state.formId = myForm.formId ;
  }
}

final alliedBusinessNotifierProvider = NotifierProvider<AlliedBusinessNotifier, AlliedBusiness>(
  (){
    final notifier = AlliedBusinessNotifier();
    notifier.setFormId();
    return notifier;
  }
);