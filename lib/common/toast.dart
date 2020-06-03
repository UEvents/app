import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool> buildToast(String message, {Color backgroundColor = Colors.red, Color textColor = Colors.white}) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
       timeInSecForIosWeb: 2,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0);
}

Future<bool> buildEventToast(String message)
{
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16
  );
}
