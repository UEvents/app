import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uevents/data/data.dart';
import 'package:uevents/domain/user.dart';
import 'package:uevents/services/database.dart';
import 'package:uevents/widgets/eventCard.dart';
import 'package:uevents/widgets/landingWidgets/eventCard.dart';
import 'package:uevents/widgets/landingWidgets/eventExtended.dart';
import 'package:uevents/widgets/personalData.dart';
import 'settingsWidgets/customListTile.dart' as settingsWidgets;

class MyEvent extends State<MyEventPage> {
  List<Data> _eventsToShow = List<Data>();
  Stream<List<Data>> _databaseEvents = DatabaseService().getEvents();
  bool _isFirst = true;
  User user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    _databaseEvents.listen((dataList) {
      if (_isFirst) {
        for (var i = 0; i < dataList.length; i++) {
          for (var j = 0; j < dataList[i].participants.length; j++) {
            if (dataList[i].participants[j] == user.id) {
              _eventsToShow.add(dataList[i]);
            }
            _isFirst = true;
            if (mounted)
              setState(() {});
          }
        }
      }
    });
    return Container(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Мои мероприятия'),
              backgroundColor: Colors.pinkAccent,
            ),
            body: CustomScrollView(slivers: [
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 20),
                      child: EventWidget(_eventsToShow[index], () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => ExtendedEvent(_eventsToShow[index])
                          )
                        );
                      },
                      () {

                      },
                      () {

                      }),
                    );
              }, childCount: _eventsToShow.length)),
    ])));
  }
}

class MyEventPage extends StatefulWidget {
  @override
  MyEvent createState() => MyEvent();
}
