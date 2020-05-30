import 'package:flutter/material.dart';
import 'package:uevents/widgets/datePicker/date_picker_timeline.dart';

class Calendar 
{
  static Widget createCalendarBar(BuildContext context) 
  {
    return Container(
      decoration: BoxDecoration( 
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), 
          ),
        ],
      ),
      child: DatePicker(
        DateTime.now(),
        daysCount: 30,
        dateTextStyle: TextStyle(color: Color.fromRGBO(134, 134, 134, 1), fontWeight: FontWeight.w300, fontSize: 18),
        selectedTextColor: Colors.white,
        selectionColor: Colors.pinkAccent,
        onDateChange: (newDate) =>
        {
          print('Date was changed to ' + newDate.toString()) //собственно то место, где нужно реагировать на изменение в дате
          //newDate - новая дата, соответственно
        },
      )
    );
  }
}