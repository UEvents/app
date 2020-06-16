import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:uevents/data/data.dart';
import 'package:uevents/domain/user.dart';
import 'package:uevents/services/addEvent.dart';
import 'package:uevents/services/auth.dart';
import 'package:uevents/services/database.dart';
import 'package:uevents/widgets/calendar.dart';
import 'package:uevents/widgets//eventCard.dart';
import 'package:uevents/widgets/landingWidgets/customListTile.dart';
import 'package:uevents/widgets/landingWidgets/filterBar.dart';
import 'package:uevents/widgets/settings.dart';

class Landing extends State<LandingPage> {
  bool _adminAccess = false;
  bool _isFirst = true;
  static Stream<List<Data>> _databaseEvents = DatabaseService().getEvents();
  List<Data> _eventsToShow = List<Data>();
  User user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);

    if (user.access.level > 0)
      setState(() { _adminAccess = true; });
    else 
      setState(() { _adminAccess = false; });

    _databaseEvents.listen((dataList) {
      if (_isFirst)
      {
        _eventsToShow = dataList;
        _isFirst = false;
        setState(() {});  
      }
    });

    return Container(
        child: Scaffold(
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 5),
            child: Container(
                height: 100,
                width: 100,
                child: Column(
                  children: <Widget>[
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(200)),
                      elevation: 15,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Image.network(
                            "https://urfu.ru/fileadmin/user_upload/common_files/about/brand/UrFULogo_U.png",
                            height: 100,
                            width: 100),
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    Text(
                      user.email, 
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                )),
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.pinkAccent, Colors.orange])),
          ),
          //CustomListTile(Icons.event_note, 'Мероприятия', () => {Navigator.push(context, MaterialPageRoute(builder: (ctx) => LandingPage()))}),       
          CustomListTile(Icons.settings, 'Настройки', () => { Navigator.push(context, MaterialPageRoute(builder: (ctx) => SettingsPage()))}),
          CustomListTile(Icons.exit_to_app, 'Выйти', () {
            //print(user.email);
            Navigator.pop(context);
            AuthService().logOut();
          }),
          ListTileWidgets.borderAfterTile(context),
          ListTileWidgets.textWidget(context),
          CustomListTile(Icons.launch, 'Перейти на сайт', () => {}),
        ],
      )),
        body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: false,
                expandedHeight: 200,
                title: Text('U.Events'),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network("https://psv4.userapi.com/c856428/u173808548/docs/d7/9ca31a4d07d4/Frame_1.png?extra=Uf1Ak7mVOyuCvtZBRuskwDBlUyzzCFcUqz006z3JUiknYoCB5dpXIMhrfEk5NrRJ37U7nsnYsKoZvTqwB1fhUg_yTRl9qaK0uRJ84Ca6Um0KBvsYD-gX9aP5zx0avl2nDy8kRkbI-IBbAeY9QU6XsShm",
                  fit: BoxFit.cover)),
              ),
              SliverToBoxAdapter(
                child: Calendar.createCalendarBar(context),
              ),
              SliverList( 
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return EventCard.createCard(context, _eventsToShow[index]);
                  },
                  childCount: _eventsToShow.length
                )    
              ),
            ]
        ),
        floatingActionButton: _adminAccess ? FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.white,
            foregroundColor: Theme.of(context).primaryColor,
            onPressed: (){
              Navigator.push<Data>(context, MaterialPageRoute(builder: (ctx) => AddEvent()));
            },    
        ) : null,
      ) 
    );
  }
}

class LandingPage extends StatefulWidget {
  @override
  Landing createState() => Landing();
}
