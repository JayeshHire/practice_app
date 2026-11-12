
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/session.dart';

@immutable
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

  FarmTool copyWith(
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
  String? formId;
}

class FarmToolNotifier extends Notifier<FarmTool> {

  @override FarmTool build() {
    final myForm = ref.watch(myFormNotifierProvider);
    return FarmTool.initialize()..formId = myForm.formId;
  }
}

final farmToolNotifierProvider = NotifierProvider<FarmToolNotifier, FarmTool>(
  FarmToolNotifier.new,
);