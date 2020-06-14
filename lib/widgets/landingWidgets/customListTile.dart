import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.white30))),
              child: InkWell(
                splashColor: Colors.pinkAccent,
                onTap: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(icon),
                        Padding(
                          child: Text(text, style: TextStyle(fontSize: 16)),
                          padding: EdgeInsets.all(8),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_right)
                  ],
                ),
              ),
            )));
  }
}

class ListTileWidgets
{
  static Widget borderAfterTile(BuildContext context) {
    return Container(
      height: 15,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Container(
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 1, color: Colors.grey[300]))),
        ),
      ),
    );
}

  static Widget textWidget(BuildContext context) {
    return Container(
      height: 45,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 13, 0, 10),
          child: Text('Ссылки',
              style: TextStyle(
                  color: Colors.grey[500], fontWeight: FontWeight.bold))),
    );
  }
}

