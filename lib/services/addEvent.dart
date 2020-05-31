import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:uevents/common/savebutton.dart';
import 'package:uevents/common/toast.dart';
import 'package:uevents/data/data.dart';
import 'package:uevents/domain/user.dart';
import 'package:uevents/services/database.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
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
  TimeOfDay _startValue;

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
                      FormElement.createTextElement("Название", (val) => event.title = val, [FormBuilderValidators.required()]),
                      FormElement.createTextElement("Краткое описание", (val) => event.shortDescription = val,
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(30),
                        FormBuilderValidators.maxLength(120)
                      ]),
                      FormElement.createTextElement("Полное описание", (val) => event.description = val, 
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.maxLength(1500)
                      ]), 
                      FormElement.createTextElement("Организатор", (val) => event.organizer = val, 
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.maxLength(100),
                      ]),
                      FormElement.createTextElement("Адрес", (val) => event.address = val, 
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.maxLength(100)
                      ]),
                      FormElement.createTextElement("Ссылка на изображение", (val) => event.imageSrc = val, 
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(30),
                        FormBuilderValidators.maxLength(120),
                      ]),
                      Container(
                        margin: EdgeInsets.only(top: 6),
                        decoration: BoxDecoration(border: Border.all()),
                        child: Text('Дата и время начала (${format.pattern})',
                            style: TextStyle(color: Colors.grey, height: 1.2)),
                      ),
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
                              _startValue = time;
                              event.date = DateTimeField.combine(date, time).toString();
                              
                              return DateTimeField.combine(date, time);
                            }
                          }
                          else
                          {
                            return currentValue;
                          }
                        },
                      ),
                      Text('Время окончания (${timeformat.pattern})', style: TextStyle(color: Colors.grey, height: 1.2)),
                      DateTimeField(
                        format: timeformat,
                        onShowPicker: (context, currentValue) async {
                          var time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          );

                          if (time.period == _startValue.period)
                          {
                            if (time.hour < _startValue.hour)
                              time = _startValue;    
                          }
                                     
                               
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
