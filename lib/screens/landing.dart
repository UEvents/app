
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uevents/data/data.dart';
import 'package:uevents/domain/showEvent.dart';
import 'package:uevents/domain/user.dart';
import 'package:uevents/services/addEvent.dart';
import 'package:uevents/services/auth.dart';
import 'package:uevents/services/database.dart';
import 'package:uevents/widgets/calendar.dart';
import 'package:uevents/widgets/settings.dart';

class Landing extends State<LandingPage> {
  User user;
  @override
  Widget build(BuildContext context) {
        user = Provider.of<User>(context);

    //на основе данных с базы (_data) создает виджеты-карточки
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('U.Events', style: TextStyle(fontSize: 25)),
        backgroundColor: Colors.pinkAccent,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                DatabaseService db = DatabaseService();
                var stream = db.getEvents();
                stream.listen((List<Data> data) {
                  setState(() {
                    //EventList.eventsToShow = data;
                  });
                });
              },
              icon: Icon(
                Icons.sync,
                color: Colors.white,
              ),
              label: SizedBox.shrink())
        ],
      ),
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
          CustomListTile(Icons.event_note, 'Мероприятия', () => {Navigator.push(context, MaterialPageRoute(builder: (ctx) => LandingPage()))}),       
          CustomListTile(Icons.settings, 'Настройки', () => {Navigator.push(context, MaterialPageRoute(builder: (ctx) => SettingsPage()))}),
          CustomListTile(Icons.exit_to_app, 'Выйти', () {
            AuthService().logOut();
            Navigator.pop(context);
          }),
          borderAfterTile(context),
          textWidget(context),
          CustomListTile(Icons.launch, 'Перейти на сайт', () => {}),
        ],
      )),
      //здесь нужно сделать выгрузку с бд всех событий (пока календарь не сделаем, всех)

        body: Column(children: [
          Calendar.createCalendarBar(context), //<================== calendarBar
          Expanded(child: EventList())
        ]),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.white,
            foregroundColor: Theme.of(context).primaryColor,
            onPressed: (){
              Navigator.push<Data>(context, MaterialPageRoute(builder: (ctx) => AddEvent()));
            },    
        ),
      ) 
    );
  }
}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.white30))),
              child: InkWell(
                splashColor: Colors.pinkAccent,
                onTap: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(icon),
                        Padding(
                          child: Text(text, style: TextStyle(fontSize: 16)),
                          padding: EdgeInsets.all(8),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_right)
                  ],
                ),
              ),
            )));
  }
}

Widget borderAfterTile(BuildContext context) {
  return Container(
    height: 15,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.grey[300]))),
      ),
    ),
  );
}

Widget textWidget(BuildContext context) {
  return Container(
    height: 45,
    child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 13, 0, 10),
        child: Text('Ссылки',
            style: TextStyle(
                color: Colors.grey[500], fontWeight: FontWeight.bold))),
  );
}

class LandingPage extends StatefulWidget {
  @override
  Landing createState() => Landing();
}
