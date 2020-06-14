import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uevents/data/data.dart';
import 'package:uevents/domain/user.dart';
import 'package:uevents/services/database.dart';
import 'package:uevents/widgets/eventCard.dart';
import 'package:uevents/widgets/landingWidgets/filterBar.dart';

class EventList extends StatefulWidget {
  static var eventsToShow = List<Data>();
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  bool _isFirst = true;
  User user;
  DatabaseService db = DatabaseService();
  

  loadData(List<String> filters) async {
    var stream = db.getEvents();
    print('loading');

    stream.listen((List<Data> data) {
      setState(() {
        EventList.eventsToShow = data;
      });
    });
  }

  Future<void> getRefresh() async 
  {
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    if (_isFirst)
    {
      loadData(null);
      _isFirst = false;
    }

    var eventCards = List<Widget>();

    HashSet<String> organizers = HashSet<String>();

    for (var i = 0; i < EventList.eventsToShow.length; i++)
    {
      if (!organizers.contains(EventList.eventsToShow[i].organizer))
        organizers.add(EventList.eventsToShow[i].organizer);
    }

    eventCards.add(Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10),
      child: Text('Мероприятия 10.06.2020', style: TextStyle(fontSize: 25))
    ));

    for (var i = 0; i < EventList.eventsToShow.length; i++)
      eventCards.add(EventCard.createCard(context, EventList.eventsToShow[i]));

    var eventlists = RefreshIndicator(
      onRefresh: () {
        loadData(null);
        return getRefresh();
      },
      child: ListView(children: eventCards));
      
    var filterBar = FilterBar(false);
    filterBar.setFilters({
      "Организаторы" : organizers.toList()
    });

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        GestureDetector(
          onTap: () { if (filterBar.isExpanded()) { filterBar.setExpansion(false); setState((){});}},
          child: eventlists,
          excludeFromSemantics: false,
        ),
        filterBar
      ]
    );
  }
}