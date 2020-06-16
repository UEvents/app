import 'package:flutter/cupertino.dart';
import 'package:uevents/data/data.dart';
import 'package:uevents/widgets/eventCard.dart';

class Event extends StatefulWidget
{
  final Data _event;

  Event(this._event);

  @override
  State<StatefulWidget> createState() => _EventState();
}

class _EventState extends State<Event>
{
  @override
  Widget build(BuildContext context) {
    return EventCard.createCard(context, widget._event);
  }
  
}