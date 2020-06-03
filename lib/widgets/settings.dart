import 'package:flutter/material.dart';

class Settings extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(13, 13, 320, 10),
            child: Text('Настройки',
                style: TextStyle(
                    color: Colors.grey[500], fontWeight: FontWeight.bold))),
           CustomListTile(Icons.person, 'Личные данные', () => {}),  
           CustomListTile(Icons.notifications, 'Уведомления', () => {}),
           CustomListTile(Icons.info_outline, 'Информация', () => {}),         
                    
      ]),
    ));
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
        height: 65,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.grey))),
              child: InkWell(
                splashColor: Colors.grey,
                onTap: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(icon, color: Colors.blue[800]),
                        Padding(
                          child: Text(text, style: TextStyle(fontSize: 16)),
                          padding: EdgeInsets.all(15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }
}

class SettingsPage extends StatefulWidget {
  @override
  Settings createState() => Settings();
}
