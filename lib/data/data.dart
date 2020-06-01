import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  String uid;
  String title;
  String shortDescription;
  String description;
  String organizer;
  String address;
  String imageSrc;
<<<<<<< HEAD
  String date;
  String startTime;
  String endTime;
  Data(this.uid,this.title, this.description, this.organizer, this.address,
      this.shortDescription, this.imageSrc, this.date, this.endTime, this.startTime);

  Data copy() {
    return Data(this.uid, this.title, this.description, this.organizer,
        this.address, this.shortDescription, this.imageSrc, this.date, this.endTime, this.startTime);
=======
  Timestamp date;
  Timestamp startTime;
  Timestamp endTime;
  Data(this.uid,this.title, this.description, this.organizer, this.address,
      this.shortDescription, this.imageSrc, this.date, this.startTime, this.endTime);

  Data copy() {
    return Data(this.uid, this.title, this.description, this.organizer,
        this.address, this.shortDescription, this.imageSrc, this.date, this.startTime, this.endTime);
>>>>>>> 2cc04d6dc2ddc13bcb234b96dfe0f5e41127285f
  }

  Data.fromJson(String uid, Map<String, dynamic> data){
    uid = uid;
    title = data['title'];
    shortDescription = data['shortDescription'];
    description = data['description'];
    organizer = data['organizer'];
    address = data['address'];
    imageSrc = data['imageSrc'];
    date = data['date'];
    startTime = data['startTime'];
    endTime = data['endTime'];
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
      "startTime": startTime,
    };
  }
}