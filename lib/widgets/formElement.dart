import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

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

  static Widget createDateElement(String label, Function(dynamic val) stateSetter, String Function(dynamic) formValidator) 
  {
    return Container(
      child: DateTimeField(
        decoration: InputDecoration( 
          labelText: label,
          labelStyle: TextStyle(fontSize: 16)
        ),
        validator: formValidator,
        format: DateFormat("yyyy-MM-dd"),
        onShowPicker: (context, currentValue) async {
          var date = await showDatePicker(
            context: context,
            firstDate: DateTime(2019),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2022)
          );

          stateSetter(date);

          return date;
        },  
      )
    );
  }

  static Widget createHourElement(String label, Function(dynamic val) stateSetter) 
  {
    var now = DateTime.now();
    var defaultTime = DateTime(now.year, now.month, now.day, 0, 0);

    return Container(
      child: DateTimeField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 16)
        ),
        format: DateFormat("HH:mm"),
        onShowPicker: (context, currentValue) async {
          var time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue == null ? defaultTime : currentValue),
          );
          
          if (time == null)
            time = TimeOfDay.fromDateTime(defaultTime);
          
          var result = defaultTime.add(Duration(hours: time.hour, minutes: time.minute));
          stateSetter(result);
          
          return result;
        },  
      )
    );
  }
}