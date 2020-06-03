import 'package:cloud_firestore/cloud_firestore.dart';
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
  Timestamp date;
  Timestamp startTime;
  Timestamp endTime;
  List<dynamic> participants;

  Data(this.uid, this.title, this.description, this.organizer, this.address,
      this.shortDescription, this.imageSrc, this.date, this.startTime, this.endTime, this.participants);

  int getday(){
    return int.parse(DateFormat("yyyy-MM-dd HH:mm").format(
                                  DateTime.fromMicrosecondsSinceEpoch(int.parse(
                                      date
                                          .toString()
                                          .split("=")[1]
                                          .split(",")[0])*1000000)).toString().split("-")[2].split(" ")[0]);
  }

  Data copy() {
    return Data(this.uid, this.title, this.description, this.organizer,
        this.address, this.shortDescription, this.imageSrc, this.date, this.startTime, this.endTime, this.participants);
  }

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
      "participants": participants
    };
  }
}