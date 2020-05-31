import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormElement 
{
  static Widget createTextElement(String label, Function(dynamic val) stateSetter, List<String Function(dynamic)> formValidators) {
    return FormBuilderTextField(
      attribute: label,
      decoration: InputDecoration(
        labelText: label,
      ),
      onChanged: (dynamic val) { stateSetter(val); },
      validators: formValidators
    ); 
  }
}