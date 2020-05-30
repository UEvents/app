import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uevents/data/data.dart';
import 'package:uevents/domain/user.dart';
import 'package:uevents/services/database.dart';
import 'package:uevents/widgets/eventCard.dart';

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  User user;
  DatabaseService db = DatabaseService();
  var eventsToShow = List<Data>();

  void filter() {
    loadData();
  }

  loadData() async {
    var stream = db.getEvents();

    stream.listen((List<Data> data) {
      setState(() {
        eventsToShow = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    filter();
    user = Provider.of<User>(context);
    var eventlists = Expanded(
        child: ListView.builder(
            itemCount: eventsToShow.length,
            itemBuilder: (context, i) {
              return EventCard.createCard(eventsToShow[i]);
            }));

    return eventlists;
  }
}