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
          onTap: () { Navigator.pop(context);},
        ),
      ),
      body: Column(children: [
        
          settingsWidgets.CustomListTile(Icons.person, 'Личные данные', 
            () => { Navigator.push(context, MaterialPageRoute(builder: (ctx) => PersonalDataPage()))}),  
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
