import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uevents/domain/user.dart';
import 'package:uevents/widgets/personalDataWidgets/customListTile.dart';

class PersonalData extends State<PersonalDataPage> {
  User user;
  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(13, 13, 285, 10),
            child: Text('Личные данные',
                style: TextStyle(
                    color: Colors.grey[500], fontWeight: FontWeight.bold))),
        CustomListTile('Email:', user.email, () => {}),
        CustomListTile('ID аккаунта:', user.id, () => {}),
      ]),
    ));
  }
}

class PersonalDataPage extends StatefulWidget {
  @override
  PersonalData createState() => PersonalData();
}
