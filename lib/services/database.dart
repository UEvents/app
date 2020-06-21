import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uevents/data/data.dart';
import 'package:uevents/domain/user.dart';

class DatabaseService{ 
  final CollectionReference _eventCollection = Firestore.instance.collection('events');
  final CollectionReference _userCollection = Firestore.instance.collection('users');
  Data data;

  Future addOrUpdateEvent(Data event) async {
    print('addorupdate');
    return await _eventCollection.document(event.uid).setData(event.toMap());
  }

  void removeEvent(Data event) async 
  {
    print('remove');
    await _eventCollection.document(event.uid).delete();
  }

  Future addOrUpdateUserInfo(User user) async {
    return await _userCollection.document(user.id).setData(user.toMap());
  }

  Stream<List<User>> getUsersInfo() {
    Query query;

    if (true){
      query = _userCollection;
    }

    return query.snapshots().map((QuerySnapshot data) =>
        data.documents.map(
            (DocumentSnapshot doc) => User.fromJson(doc.documentID, doc.data)).toList());
  }

  Stream<List<Data>> getEvents() {
    Query query;

    if (true){
      query = _eventCollection;
    }

    return query.snapshots().map((QuerySnapshot data) =>
        data.documents.map(
            (DocumentSnapshot doc) => Data.fromJson(doc.documentID, doc.data)).toList());
  }
}
