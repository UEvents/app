import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final Function onPressedFunc;

  SaveButton({Key key, @required this.onPressedFunc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(0.0),
          side: BorderSide(color: Colors.pinkAccent)),
      onPressed: onPressedFunc,
      color: Colors.pinkAccent,
      textColor: Colors.white,
      child:
          Icon(Icons.save),
    );
  }
}