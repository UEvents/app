import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uevents/domain/user.dart';
import 'package:uevents/screens/auth.dart';
import 'landing.dart';

class Switcher extends StatelessWidget {
  const Switcher({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    final bool isLoggedIn = user !=null;
    return isLoggedIn ? LandingPage() : AuthorizationPage();
  }
}