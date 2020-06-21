import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:uevents/common/savebutton.dart';
import 'package:uevents/common/toast.dart';
import 'package:uevents/data/data.dart';
import 'package:uevents/domain/user.dart';
import 'package:uevents/services/auth.dart';
import 'package:uevents/services/database.dart';
import 'package:intl/intl.dart';
import 'package:uevents/widgets/formElement.dart';

class AddEvent extends StatefulWidget {
  AddEvent({Key key}) : super(key: key);

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _fbKey = GlobalKey<FormBuilderState>();
  User user;
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final timeformat = DateFormat("HH:mm");

  Data event = Data(
    'id',
    'empty',
    'empty',
    'empty',
    'empty',
    'empty',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/8/80/Yandex_Browser_logo.svg/1200px-Yandex_Browser_logo.svg.png',
    Timestamp.fromDate(DateTime.now()),
    Timestamp.fromDate(DateTime.now()),
    Timestamp.fromDate(DateTime.now()),
    new List<User>(),
    null
  );

  @override
  void initState() {
    super.initState();
  }

  void _saveEvent() async {
    print('saveevent');
    if (_fbKey.currentState.saveAndValidate()) {
      if (event == null) {
        buildToast('Проверьте корректность введенных Вами данных');
        return;
      }

      if (event.uid == 'id') {
        event.uid = DateTime.now().millisecondsSinceEpoch.toString();
      }
      await DatabaseService().addOrUpdateEvent(event);
      Navigator.of(context).pop();
    } else {
      buildToast('Упс! Что-то пошло не так');
    }
  }
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);

    event.organizer = user.name;
    event.organizerRef = Firestore.instance.collection('users').document(user.id);
    event.organizerAvatarSrc = user.avatarUrl;

    return Container(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Создание мероприятия', style: TextStyle(fontSize: 18)),
              backgroundColor: Colors.pinkAccent,
              actions: <Widget>[SaveButton(onPressedFunc: _saveEvent)],
            ),
            backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white),
              child: ListView(
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                    autovalidate: false,
                    initialValue: {},
                    readOnly: false,
                    child: Column(children: <Widget>[
                      FormElement.createTextElement("Название", (val) => event.title = val, [FormBuilderValidators.required()]),
                      FormElement.createTextElement("Краткое описание", (val) => event.shortDescription = val,
                      [
                        FormBuilderValidators.required(),
                        //FormBuilderValidators.minLength(30),
                        FormBuilderValidators.maxLength(150)
                      ]),
                      FormElement.createTextElement("Полное описание", (val) => event.description = val, 
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.maxLength(1500)
                      ]), 
                      //FormElement.createTextElement("Организатор", (val) => event.organizer = val, 
                      //[
                      //  FormBuilderValidators.required(),
                      //  FormBuilderValidators.maxLength(100),
                      //]),
                      FormElement.createTextElement("Адрес", (val) => event.address = val, 
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.maxLength(100)
                      ]),
                      FormElement.createTextElement("Ссылка на изображение", (val) => event.imageSrc = val, 
                      [
                        FormBuilderValidators.required(errorText: "Поле не может быть пустым"),
                      ]),
                      FormElement.createDateElement("Дата проведения", (val) => 
                      {
                        if (val != null)
                          event.date = Timestamp.fromDate(val)                  
                      }, FormBuilderValidators.required(errorText: "Поле не может быть пустым")),
                      FormElement.createHourElement("Время начала", (val) =>
                        event.startTime = Timestamp.fromMillisecondsSinceEpoch(val.millisecondsSinceEpoch)),
                      FormElement.createHourElement("Время окончания", (val) =>
                        event.endTime = Timestamp.fromMillisecondsSinceEpoch(val.millisecondsSinceEpoch)),
                    ]),
                  ),
                ],
              ),
            )));
  }
}
