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
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 15, left: 14),
          child: Text('Личные данные',
            style: TextStyle(
                color: Colors.grey[500], fontWeight: FontWeight.bold)),
        ),
        CustomListTile('Email:', user.email, () => {}),
        CustomListTile('ID аккаунта:', user.id, () => {}),
        CustomListTile('Уровень доступа: ', user.access.toString(), () => {})
      ]),
    ));
  }
}

class PersonalDataPage extends StatefulWidget {
  @override
  PersonalData createState() => PersonalData();
}
