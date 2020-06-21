import 'package:flutter/material.dart';
import 'package:uevents/screens/landing.dart';
import 'package:uevents/widgets/datePicker/date_picker_timeline.dart';

class CalendarWidget extends StatefulWidget
{
  int currentDay = DateTime.now().day;

  @override
  State<StatefulWidget> createState() => _CalendarWidgetState();  
}

class _CalendarWidgetState extends State<CalendarWidget>
{
  static int divider = 1000000;

  @override
  Widget build(BuildContext context) {
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
        initialSelectedDate: DateTime.now(),
        onDateChange: (newDate) =>
        {
          newDate.microsecondsSinceEpoch,
          Landing.currentDay = newDate.day, 
          setState(() {})
        },
      )
    );
  }

}