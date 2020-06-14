import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String accountInformation;
  final String text;
  final Function onTap;

  CustomListTile(this.text, this.accountInformation, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Container(
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(width: 1, color: Colors.grey))),
              child: InkWell(
                splashColor: Colors.grey,
                onTap: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          child: Text(text, style: TextStyle(fontSize: 16)),
                          padding: EdgeInsets.all(5),
                        ),
                        Padding(
                          child: Text(accountInformation,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[600])),
                          padding: EdgeInsets.all(5),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }
}