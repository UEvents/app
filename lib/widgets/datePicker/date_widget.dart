import 'package:flutter/material.dart';
import 'gestures/tap.dart';

class DateWidget extends StatelessWidget {
  final double width;
  final DateTime date;
  final TextStyle monthTextStyle, dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final DateSelectionCallback onDateSelected;
  final String locale;

  DateWidget(
  {
    @required this.date,
    @required this.monthTextStyle,
    @required this.dayTextStyle,
    @required this.dateTextStyle,
    @required this.selectionColor,
    this.width,
    this.onDateSelected,
    this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100.0)),
          border: Border.all(color: Color.fromRGBO(216, 216, 216, 1)),
          color: selectionColor
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Container( 
            alignment: Alignment.center,
            child: Text(date.day.toString(), // Date
                style: dateTextStyle)
          )
        ),
      ),
      onTap: () {
        if (onDateSelected != null) {
          onDateSelected(this.date);
        }
      },
    );
  }
}
