import 'package:flutter/material.dart';
import 'package:uevents/screens/landing.dart';

void main() => runApp(UEvents());

class UEvents extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness',
      theme: ThemeData( 
        //primaryColor: Color.fromRGBO(60, 65, 85, 1),
        
        textTheme: TextTheme(headline6: TextStyle(color: Colors.white))
      ),
      home: LandingPage()
    );
  }
}

