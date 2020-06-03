import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uevents/domain/user.dart';

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

class CustomListTile extends StatelessWidget {
  String accountInformation;
  String text;
  Function onTap;

  CustomListTile(this.text, this.accountInformation, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Container(
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(width: 1, color: Colors.grey))),
              child: InkWell(
                splashColor: Colors.grey,
                onTap: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          child: Text(text, style: TextStyle(fontSize: 16)),
                          padding: EdgeInsets.all(5),
                        ),
                        Padding(
                          child: Text(accountInformation,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[600])),
                          padding: EdgeInsets.all(5),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }
}

class PersonalDataPage extends StatefulWidget {
  @override
  PersonalData createState() => PersonalData();
}
