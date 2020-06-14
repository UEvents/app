import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uevents/screens/switcher.dart';
import 'temp/routingTests.dart' as tests;
import 'domain/user.dart';
import 'services/auth.dart';

void main() => runApp(UEvents());

class UEvents extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().currentUser,
        child: MaterialApp(
          title: 'U.Events',
          theme: ThemeData( 
            primaryColor: Colors.pinkAccent,
            textTheme: TextTheme(headline6: TextStyle(color: Colors.white))
          ),
          home: Switcher()
        )
    );
  }
}

