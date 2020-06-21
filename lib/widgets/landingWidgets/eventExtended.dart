import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:uevents/common/toast.dart';
import 'package:uevents/data/data.dart';
import 'package:uevents/services/auth.dart';
import 'package:uevents/services/database.dart';

  class ExtendedEvent extends StatefulWidget {
    final Data _data;

    ExtendedEvent(this._data);

    @override
    _ExtendedEventState createState() => _ExtendedEventState();
  }
  
  class _ExtendedEventState extends State<ExtendedEvent> {
    String _userId;
    bool _takesPart = false;

    @override
    void initState() {
      super.initState();
      AuthService().currentUser.listen((user) { if (user != null) _userId = user.id; setState(() {}); });
    }

    @override
    Widget build(BuildContext context) {
      Data data = widget._data;
      DateTime startTime = data.startTime.toDate();
      DateTime endTime = data.endTime.toDate();
      DateTime date = data.date.toDate();
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
      body: CustomScrollView( 
        slivers: [
          SliverPersistentHeader( 
            floating: false,
            delegate: EventExtendedPageHeader(
              minExtent: 150, 
              maxExtent: 250,
              data: data
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              //padding: EdgeInsets.symmetric(horizontal: 20),

              child: Material(
                //color: Color.fromRGBO(229, 229, 229, 1),
                //borderRadius: BorderRadius.all(Radius.circular(10)),
                //elevation: 3,

                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    data.description,
                    style: TextStyle(fontSize: 20)
                  )
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Material(
                //color: Color.fromRGBO(229, 229, 229, 1),
                //elevation: 3,

                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getInfoTextLine("Организатор", data.organizer),
                      _getInfoTextLine("Дата проведения", DateFormat("dd.MM.yyyy").format(date)),
                      _getInfoTextLine("Время проведения", DateFormat("HH:mm").format(startTime) + ' - ' 
                        + DateFormat("HH:mm").format(endTime)),
                      _getInfoTextLine("Место проведения", data.address),
                      _getInfoTextLine("Лимит участников", 'нет'),
                      _getInfoTextLine("Количество участников", data.participants.length.toString()),
                    ],
                  )
                ),
              ),
            ),
          ),

          SliverToBoxAdapter( 
            child: Container(
              margin: EdgeInsets.only(top: 5, bottom: 15),
              alignment: Alignment.center,

              child: FlatButton( 
                onPressed: () {
                  if (data != null) 
                  {
                    if (data.participants.contains(_userId))
                    {
                      data.participants.remove(_userId);
                      //buildEventToast("Вы отказались от участия в мероприятии");
                    }
                    else
                      data.participants.add(_userId);                                      
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
                      width: 200,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        _takesPart ? 'ОТМЕНИТЬ УЧАСТИЕ' : 'ЗАПИСАТЬСЯ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17
                        )
                      ),
                    ),
                  ),
                )
              )
            ],
          )
      );





      
      //ListView(children: [
      //  Container(
      //    child: Column( 
      //      children: <Widget>[
      //        Container( 
      //          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      //        ),
      //        Padding(
      //          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      //          child: Text(data.title, style: TextStyle(decoration: null, color: Colors.black, fontSize: 30)),
      //        ),
      //        Container(
      //          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      //          child: Flex(
      //            direction: Axis.horizontal,
      //            children: [
      //              Flexible( 
      //                child: Text(data.description, style: TextStyle(fontSize: 20)),
      //              )
      //            ]
      //          ),
      //        ),
      //        Container(
      //        alignment: Alignment.centerRight,
      //        margin: EdgeInsets.fromLTRB(0, 10, 21, 0),
      //        child: FlatButton( 
      //        onPressed: () {
      //          if (data != null) 
      //          {
      //            if (data.participants.contains(_userId))
      //            {
      //              data.participants.remove(_userId);
      //              buildEventToast("Вы отказались от участия в мероприятии");
      //            }
      //            else
      //              data.participants.add(_userId);                                      
      //          }
      //          DatabaseService().addOrUpdateEvent(data);
//
      //          setState(() { });
      //        }, //id
      //        shape: RoundedRectangleBorder(
      //          borderRadius: BorderRadius.circular(5.0),
      //          side: BorderSide(color: Colors.red)
      //        ),
      //        color: (_takesPart ? Colors.pink : Colors.pinkAccent),
      //        textColor: Colors.white,
      //        child: Container(
      //          width: 160,
      //          height: 30,
      //          alignment: Alignment.center,
      //          child: Text(
      //            _takesPart ? 'ОТМЕНИТЬ УЧАСТИЕ' : 'ЗАПИСАТЬСЯ',
      //            style: TextStyle(color: Colors.white)
      //            ),
      //        ),
      //      ),
      //    ),
      //  ],
      //),
      //),
      //]),
  }

  Text _getInfoTextLine(String label, String value)
  {
    return Text(label + ': ' + value, style: TextStyle(fontSize: 18));
  }
}

class EventExtendedPageHeader implements SliverPersistentHeaderDelegate {
  EventExtendedPageHeader({
    this.minExtent,
    @required this.maxExtent,
    @required this.data
  });

  final Data data;
  final double minExtent;
  final double maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'resources/background.png',
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black54],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: Text(
            data.title,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white.withOpacity(titleOpacity(shrinkOffset)),
            ),
          ),
        ),
      ],
    );
  }

  double titleOpacity(double shrinkOffset) {
    return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}