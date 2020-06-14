import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_form_builder/flutter_form_builder.dart';

class Landing extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => LandingState();
}

class LandingState extends State<Landing> 
{
  bool _boolean = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent
      ),
      drawer: Drawer( 
        child: ListView(children:  <Widget>[
          DrawerHeader(
            child: Container(color: Colors.blueGrey, margin: EdgeInsets.all(0),)
          ),
          InkWell(
            splashColor: _boolean ? Colors.blueGrey : Colors.black,
            onTap: () {},
            onDoubleTap: () { setState(() { _boolean = !_boolean; }); }, 
            child: Container(alignment: Alignment.center, child: Text('some control element')
          ),
          )
        ],)

      ),
      body: ListView.builder(
        physics: CustomScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, i) {
          return Container( 
            color: Color.fromRGBO(i, i*2, i*3, 1),
            width: 200,
            height: 100,
            alignment: Alignment.center,
            child: Text(i.toString())
          );
        }),
    );
  }
}

class CustomScrollPhysics extends ScrollPhysics
{
  @override 
  ScrollPhysics applyTo(ScrollPhysics ancestor)
  {
    return CustomScrollPhysics();
  }

  @override 
  Simulation createBallisticSimulation(ScrollMetrics position, double velocity)
  {
    return CustomSimulation(position.pixels, velocity);
  }
}

class CustomSimulation extends Simulation
{
  final double velocity;
  final double initPosition;

  CustomSimulation(this.initPosition, this.velocity);

  @override
  double dx(double time) {
    return time;
  }
  
  @override
  bool isDone(double time) {
    if (velocity == 0)
      return true;
    return false;
  }
  
  @override
  x(double time) {
    return initPosition * dx(time);
  }
}