// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/main.dart';
import 'package:my_app/models/m_utils.dart';
import 'package:uuid/uuid.dart';

class MyForm {


  final String formId ;
  // enum
  final FormStatus status;
  // This field is populated when the farmer form is saved
  int? farmerId; 
  
  MyForm(this.status, {String? formId, int? farmerId}): this.formId = formId?? uuid.v4();


  MyForm copyWith({
    FormStatus? status,
    String? formId,
    int? farmerId
  }) {
    return MyForm(
      status ?? this.status,
      formId: formId?? this.formId,
      farmerId: farmerId?? this.farmerId
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'formId': formId,
      'status': status.index,
      'farmerId': farmerId
    };
  }

  factory MyForm.fromMap(Map<String, dynamic> map) {
    return MyForm(
      map["status"],
      formId: map["formId"],
      farmerId: map["farmerId"]
    );
  }

  String toJson() => json.encode(toMap());

  factory MyForm.fromJson(String source) => MyForm.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MyForm( formId: $formId, status: $status)';

  @override
  bool operator ==(covariant MyForm other) {
    if (identical(this, other)) return true;
  
    return 
      other.formId ==  formId &&
      other.status == status;
  }

  @override
  int get hashCode => formId.hashCode ^ status.hashCode;
}

class MyFormNotifier extends Notifier<MyForm> {
  
  @override
  MyForm build() {
    return MyForm(FormStatus.INCOMPLETE);
  }
}

final myFormNotifierProvider = NotifierProvider<MyFormNotifier, MyForm>((){
  return MyFormNotifier();
});

class MyFormListNotifier extends Notifier<List<MyForm>>{

  @override
  List<MyForm> build() {
    return <MyForm>[];
  }

  void addMyForm(MyForm myForm){
    state = [...state, myForm];
  }

  void removeMyForm(String formId){
    state = state.where((f) => f.formId != formId).toList();
  }

  void updateStatusToCompleted(String formId){
    state = [
      for (final f in state)
        if (f.formId == formId)
          f.copyWith(status: FormStatus.COMPLETED)
        else
          f
    ];
  }
}

final myFormListNotifierProvider = NotifierProvider<MyFormListNotifier, List<MyForm>>(
  () => MyFormListNotifier()
);