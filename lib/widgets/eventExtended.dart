import 'package:flutter/material.dart';
import 'package:uevents/data/data.dart';

class EventExtended
{
  static Widget getExtendedEvent(BuildContext context, Data data)
  {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(225, 225, 225, 1)),
      child: Column( 
        children: <Widget>[
          Container( 
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(data.title, style: TextStyle(fontSize: 20)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Flexible( 
                  child: Text(data.description),
                )
              ]
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.fromLTRB(0, 10, 21, 0),
            child: FlatButton( 
              onPressed: (){},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.red)
              ),
              color: Colors.pinkAccent,
              textColor: Colors.white,
              child: Container(
                width: 160,
                height: 30,
                alignment: Alignment.center,
                child: Text('ЗАПИСАТЬСЯ', style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}