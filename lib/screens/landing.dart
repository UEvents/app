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
import 'package:uevents/widgets/datePicker/date_picker_widget.dart';
import 'package:uevents/widgets/landingWidgets/eventExtended.dart';
import 'package:uevents/widgets/landingWidgets/eventCard.dart';
import 'package:uevents/widgets/landingWidgets/customListTile.dart';
import 'package:uevents/widgets/myEvents.dart';
import 'package:uevents/widgets/settings.dart';
import 'package:url_launcher/url_launcher.dart';

class Landing extends State<LandingPage> {
  static int currentDay = DateTime.now().day;
  bool _adminAccess = false;
  Stream<List<Data>> _databaseEvents = DatabaseService().getEvents();
  List<Data> _eventsToShow = List<Data>();
  static User user; 
  
  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    print(currentDay);

    if (user.access.level > 0)
      setState(() { _adminAccess = true; });
    else 
      setState(() { _adminAccess = false; });

    _databaseEvents.listen((dataList) {
      if (this.mounted)
        setState(() { _eventsToShow = dataList; });  
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            user.avatarUrl,
                            height: 100,
                            width: 100
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    Text(
                      user.name, 
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                )),
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.pinkAccent, Colors.orange])),
          ),
          CustomListTile(Icons.event_note, 'Мероприятия', () => {Navigator.pop(context)}),   
          CustomListTile(Icons.event_available, 'Мои мероприятия', () => { Navigator.push(context, MaterialPageRoute(builder: (ctx) => MyEventPage()))}),   
          CustomListTile(Icons.settings, 'Настройки', () => { Navigator.push(context, MaterialPageRoute(builder: (ctx) => SettingsPage()))}),
          CustomListTile(Icons.exit_to_app, 'Выйти', () {
            //print(user.email);
            Navigator.pop(context);
            AuthService().logOut();
          }),
          ListTileWidgets.borderAfterTile(context),
          ListTileWidgets.textWidget(context),
          CustomListTile(Icons.launch, 'Перейти на сайт', () => {_launchURL()}),
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
                  background: Image.asset('resources/background.png',
                  fit: BoxFit.cover)),
              ),
              SliverToBoxAdapter(
                child: Container(
              decoration: BoxDecoration( 
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), 
                  ),
                ],
              ),
              child: DatePicker(
                DateTime.now(),
                daysCount: 30,
                dateTextStyle: TextStyle(color: Color.fromRGBO(134, 134, 134, 1), fontWeight: FontWeight.w300, fontSize: 18),
                selectedTextColor: Colors.white,
                selectionColor: Colors.pinkAccent,
                initialSelectedDate: DateTime.now(),
                onDateChange: (newDate) =>
                {
                  newDate.microsecondsSinceEpoch,
                  Landing.currentDay = newDate.day, 
                  setState(() {})
                },))
              ),
              SliverList( 
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var list = _eventsToShow.where((element) => element.date.toDate().day == currentDay).toList();
                    return Container(
                      margin: EdgeInsets.only(top: 30),
                      child: EventWidget(list[index], 
                        () {
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) => ExtendedEvent(list[index])));
                        },
                        () {
                          showDialog(context: context, builder: (cont) =>
                            AlertDialog(
                              title: Text('Вы уверены что хотите удалить это мероприятие?', style: TextStyle(color: Colors.black)),
                              actions: [
                                FlatButton(child: Text('Нет'), onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                                FlatButton(child: Text('Да'), onPressed: () {
                                  DatabaseService().removeEvent(list[index]);
                                  Navigator.of(context).pop();
                                })
                              ]
                            )
                          );
                        },
                        () {
                          showDialog(context: context, builder: (cont) =>
                            AlertDialog(
                              title: Text('Изменить информацию об этом мероприятии?', style: TextStyle(color: Colors.black)),
                              actions: [
                                FlatButton(child: Text('Нет'), onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                                FlatButton(child: Text('Да'), onPressed: () {
                                  Navigator.of(context).pop();
                                })
                              ]
                            )
                          );
                        }
                     )
                    );
                  },
                  childCount: _eventsToShow.where((element) => element.date.toDate().day == currentDay).length
                )    
              ),
            ]
        ),
        floatingActionButton: _adminAccess ? FloatingActionButton(
          elevation: 7,
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
  _launchURL() async {
  const url = 'https://urfu.ru/ru/events/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
}

class LandingPage extends StatefulWidget {
  @override
  Landing createState() => Landing();
}
