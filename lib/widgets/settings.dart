import 'package:flutter/material.dart';
import 'package:uevents/widgets/personalData.dart';
import 'settingsWidgets/customListTile.dart' as settingsWidgets;

class Settings extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
        backgroundColor: Colors.pinkAccent,
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () { print('returning from Settings to Main Screen'); Navigator.pop(context);},
        ),
      ),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(13, 13, 320, 10),
            child: Text('Настройки',
                style: TextStyle(
                    color: Colors.grey[500], fontWeight: FontWeight.bold))),
           settingsWidgets.CustomListTile(Icons.person, 'Личные данные', () => {Navigator.push(context, MaterialPageRoute(builder: (ctx) => PersonalDataPage()))}),  
           settingsWidgets.CustomListTile(Icons.notifications, 'Уведомления', () => {}),
           settingsWidgets.CustomListTile(Icons.info_outline, 'Информация', () => {}),           
      ]),
    ));
  }
}

class SettingsPage extends StatefulWidget {
  @override
  Settings createState() => Settings();
}
