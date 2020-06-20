import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uevents/data/data.dart';
import 'package:uevents/widgets/eventCard.dart';
import 'package:uevents/widgets/landingWidgets/eventCard.dart';

class Landing extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => LandingState();
}

class LandingState extends State<Landing> 
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent
      ),
      body: EventWidget(Data.placeHolder()),
    );
  }
}