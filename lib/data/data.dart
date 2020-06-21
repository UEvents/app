import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uevents/domain/user.dart';

class Data {
  String uid;
  String title;
  String shortDescription;
  String description;
  String organizer;
  String address;
  String imageSrc;
  DocumentReference organizerRef;
  Timestamp date;
  Timestamp startTime;
  Timestamp endTime;
  List<dynamic> participants;

  Data.placeHolder() 
  {
    String _loremIpsum = 'Давно выяснено, что при оценке дизайна и композиции читаемый'
      + 'текст мешает сосредоточиться. Lorem Ipsum используют потому, что тот обеспечивает более' 
      + 'или менее стандартное заполнение шаблона.';


    uid = 'abcde'; title = 'Заголовок';
      shortDescription = _loremIpsum; description = 'Полное описание';
        address = 'Адрес'; organizer = 'Организатор'; imageSrc = 'imageSrc'; date = Timestamp.now();
          startTime = Timestamp.now(); endTime = Timestamp.now(); participants = List<dynamic>();
  }

  Data(this.uid, this.title, this.description, this.organizer, this.address,
      this.shortDescription, this.imageSrc, this.date, this.startTime, this.endTime, this.participants, this.organizerRef) 
      {
        if (organizerRef != null) 
          organizerRef.get().asStream().listen((event) {
            organizer = event.data['name'];
            print(organizer);
          });
      }

  //Data copy() {
  //  return Data(this.uid, this.title, this.description, this.organizer,
  //      this.address, this.shortDescription, this.imageSrc, this.date, this.startTime, this.endTime, this.participants,
  //      this.organizerRef);
  //}

  Data.fromJson(String uid, Map<String, dynamic> data){
    this.uid = data['uid'];
    title = data['title'];
    shortDescription = data['shortDescription'];
    description = data['description'];
    organizer = data['organizer'];
    address = data['address'];
    imageSrc = data['imageSrc'];
    date = data['date'];
    startTime = data['startTime'];
    endTime = data['endTime'];
    participants = data['participants'];
    organizerRef = data['organizerRef'];
  }

   Map<String, dynamic> toMap(){
    return {
      "title": title,
      "description": description,
      "shortDescription": shortDescription,
      "organizer": organizer,
      "uid": uid,
      "address": address,
      "imageSrc": imageSrc,
      "date": date,
      "startTime": startTime,
      "endTime": endTime,
      "participants": participants,
      "organizerRef": organizerRef
    };
  }
}