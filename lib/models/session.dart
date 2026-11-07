// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/main.dart';
import 'package:uuid/uuid.dart';

enum FormStatus {
  COMPLETED,
  INCOMPLETE
}

class MyForm {


  final String formId ;
  // enum
  final FormStatus status;
  
  MyForm(this.status, {String? formId}): this.formId = formId?? uuid.v4();


  MyForm copyWith({
    FormStatus? status,
    String? formId
  }) {
    return MyForm(
      status ?? this.status,
      formId: formId?? this.formId
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'formId': formId,
      'status': status.index,
    };
  }

  factory MyForm.fromMap(Map<String, dynamic> map) {
    return MyForm(
      map["status"],
      formId: map["formId"]
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