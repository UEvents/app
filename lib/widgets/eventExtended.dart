import 'package:flutter/material.dart';
import 'package:uevents/data/data.dart';
import 'package:uevents/domain/user.dart';
import 'package:uevents/services/auth.dart';

class EventExtended
{
  static Widget getExtendedEvent(BuildContext context, Data data)
  {
    return Scaffold(
      appBar: AppBar( 
        leading: FlatButton(
          child:  Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => {
            Navigator.pop(context)
          },
        ),
        title: Text('Записаться на мероприятие'),
      ),
      body: ListView(children: [
        Container(
        child: Column( 
          children: <Widget>[
            Container( 
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(data.title, style: TextStyle(decoration: null, color: Colors.black, fontSize: 30)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible( 
                    child: Text(data.description, style: TextStyle(fontSize: 20)),
                  )
                ]
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.fromLTRB(0, 10, 21, 0),
              child: FlatButton( 
                onPressed: () { data.participants.add(User("0", "a")); },
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
                  child: Text('ЗАПИСАТЬСЯ', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            
          ],
        ),
      ),
      ]),
    );
  }
}