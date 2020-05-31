import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:uevents/common/savebutton.dart';
import 'package:uevents/common/toast.dart';
import 'package:uevents/data/data.dart';
import 'package:uevents/domain/user.dart';
import 'package:uevents/services/database.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

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
    'a',
    'a',
    'a',
    'a',
    'a',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/8/80/Yandex_Browser_logo.svg/1200px-Yandex_Browser_logo.svg.png',
    DateTime.now().toString(),
    DateTime.now().toString(),
  );

  @override
  void initState() {
    super.initState();
  }

  void _saveEvent() async {
    if (_fbKey.currentState.saveAndValidate()) {
      if (event == null) {
        buildToast('Пожалуйста, проверьте ивент');
        return;
      }
      DateTime now = DateTime.now();

      if (event.uid == 'id') {
        event.uid = user.id + now.toString();
      }
      await DatabaseService().addOrUpdateEvent(event);
      Navigator.of(context).pop();
    } else {
      buildToast('Упс! Что-то пошло не так');
    }
  }

  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return Container(
        child: Scaffold(
            appBar: AppBar(
              title:
                  Text('Создание мероприятия', style: TextStyle(fontSize: 20)),
              backgroundColor: Colors.pinkAccent,
              actions: <Widget>[SaveButton(onPressed: _saveEvent)],
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
                      FormBuilderTextField(
                        attribute: "название",
                        decoration: InputDecoration(
                          labelText: "Название*",
                        ),
                        onChanged: (dynamic val) {
                          setState(() {
                            event.title = val;
                          });
                        },
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.maxLength(100),
                        ],
                      ),
                      FormBuilderTextField(
                        attribute: "краткое описание",
                        decoration: InputDecoration(
                          labelText: "Краткое описание*",
                        ),
                        onChanged: (dynamic val) {
                          setState(() {
                            event.shortDescription = val;
                          });
                        },
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.minLength(30),
                          FormBuilderValidators.maxLength(120),
                        ],
                      ),
                      FormBuilderTextField(
                        attribute: "полное описание",
                        decoration: InputDecoration(
                          labelText: "Полное описание*",
                        ),
                        onChanged: (dynamic val) {
                          setState(() {
                            event.description = val;
                          });
                        },
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.maxLength(1500),
                        ],
                      ),
                      FormBuilderTextField(
                        attribute: "организатор",
                        decoration: InputDecoration(
                          labelText: "Организатор*",
                        ),
                        onChanged: (dynamic val) {
                          setState(() {
                            event.organizer = val;
                          });
                        },
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.maxLength(100),
                        ],
                      ),
                      FormBuilderTextField(
                        attribute: "адрес",
                        decoration: InputDecoration(
                          labelText: "Адрес*",
                        ),
                        onChanged: (dynamic val) {
                          setState(() {
                            event.address = val;
                          });
                        },
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.maxLength(100),
                        ],
                      ),
                      FormBuilderTextField(
                        attribute: "ссылка на картинку",
                        decoration: InputDecoration(
                          labelText: "Ссылка на картинку*",
                        ),
                        onChanged: (dynamic val) {
                          setState(() {
                            event.imageSrc = val;
                          });
                        },
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.minLength(30),
                          FormBuilderValidators.maxLength(120),
                        ],
                      ),
                      Text('Дата и время начала (${format.pattern})',
                          style: TextStyle(color: Colors.grey, height: 1.2)),
                      DateTimeField(
                        format: format,
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                          if (date != null) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                  currentValue ?? DateTime.now()),
                            );
                            if (date != null && time != null) {
                              event.date =
                                  DateTimeField.combine(date, time).toString();
                              return DateTimeField.combine(date, time);
                            }
                          } else {
                            return currentValue;
                          }
                        },
                      ),
                      Text('Время окончания (${timeformat.pattern})',style: TextStyle(color: Colors.grey, height: 1.2)),
                      DateTimeField(
                        format: timeformat,
                        onShowPicker: (context, currentValue) async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          );
                          event.endTime = time.toString();
                          return DateTimeField.convert(time);
                        },
                      ),
                    ]),
                  ),
                ],
              ),
            )));
  }
}
