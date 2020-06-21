import 'package:firebase_auth/firebase_auth.dart';
import 'package:uevents/services/database.dart';
import 'access.dart';

class User {
  String id;
  String name;
  String email;
  Access access;
  String avatarUrl;

  User(this.id, this.name);

  User.fromFirebase(FirebaseUser fUser){
    id = fUser.uid;
    name = "null";
    email = fUser.email;
    access = Access(0);

    var userStream = DatabaseService().getUsersInfo();

    userStream.listen((List<User> userList) {
      userList.forEach((element) { 
        if (id == element.id)
        {
          access = element.access;
          name = element.name;
          avatarUrl = element.avatarUrl;
        }
          
        print(element.name + ': ' + element.access.toString());
      });
    });
  }

  Map<String, dynamic> toMap(){
    return {
      "id" : id,
      "name" : name,
      "email" : email,
      "accessLevel": access.level,
      "avatarUrl": avatarUrl
    };
  }

  User.fromJson(String uid, Map<String, dynamic> data){
    id = data['id'];
    name = data['name'];
    email = data['email'];
    avatarUrl = data['avatarUrl'];
    if (access == null)
      access = Access(0);
    access.level = data['accessLevel'];
  }

  
}