import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uevents/data/data.dart';
import 'package:uevents/domain/user.dart';
import 'package:uevents/services/database.dart';
import 'package:uevents/widgets/eventCard.dart';

class EventList extends StatefulWidget {
  static var eventsToShow = List<Data>();
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  bool _isFirst = true;
  User user;
  DatabaseService db = DatabaseService();
  

  loadData() async {
    var stream = db.getEvents();

    stream.listen((List<Data> data) {
      setState(() {
        EventList.eventsToShow = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirst)
    {
      loadData();
      _isFirst = false;
    }

    user = Provider.of<User>(context);
    var eventlists = Expanded(
        child: ListView.builder(
            itemCount: EventList.eventsToShow.length,
            itemBuilder: (context, i) {
              return EventCard.createCard(context, EventList.eventsToShow[i]);
            }));

    return eventlists;
  }
}