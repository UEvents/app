import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uevents/data/data.dart';
import 'package:uevents/widgets/calendar.dart';

class DatabaseService{
  final CollectionReference _eventCollection = Firestore.instance.collection('events');
  Data data;
  Future addOrUpdateEvent(Data events) async {
    return await _eventCollection.document(events.uid).setData(events.toMap());
  }

  Stream<List<Data>> getEvents() {
    Query query;
    if (true){
      query = _eventCollection.where('title', isEqualTo: Calendar.currentDay);
    }
    return query.snapshots().map((QuerySnapshot data) =>
        data.documents.map(
            (DocumentSnapshot doc) => Data.fromJson(doc.documentID, doc.data)).toList());
  }
}
