import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uevents/common/toast.dart';
import 'package:uevents/data/data.dart';
import 'package:uevents/services/auth.dart';
import 'package:uevents/services/database.dart';

  class ExtendedEvent extends StatefulWidget {
    ExtendedEvent({Key key}) : super(key: key);
    Data _data;

    ExtendedEvent.construct(data) { _data = data; }

    @override
    _ExtendedEventState createState() => _ExtendedEventState();
  }
  
  class _ExtendedEventState extends State<ExtendedEvent> {
    String _userId;
    bool _takesPart = false;
    Data data;

    @override
    void initState() {
      super.initState();
      AuthService().currentUser.listen((user) { _userId = user.id; setState(() {}); });
    }

    @override
    Widget build(BuildContext context) {
      data = widget._data;
      _takesPart = data.participants != null ? data.participants.contains(_userId) : false;

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
              onPressed: () {
                if (data != null) 
                {
                  if (data.participants.contains(_userId))
                  {
                    data.participants.remove(_userId);
                    buildEventToast("Вы отказались от участия в мероприятии");
                  }
                  else
                  {
                    data.participants.add(_userId);   
                  }                                         
                }
                DatabaseService().addOrUpdateEvent(data);

                setState(() { });
              }, //id
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.red)
              ),
              color: (_takesPart ? Colors.pink : Colors.pinkAccent),
              textColor: Colors.white,
              child: Container(
                width: 160,
                height: 30,
                alignment: Alignment.center,
                child: Text(
                  _takesPart ? 'ОТМЕНИТЬ УЧАСТИЕ' : 'ЗАПИСАТЬСЯ',
                  style: TextStyle(color: Colors.white)
                  ),
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