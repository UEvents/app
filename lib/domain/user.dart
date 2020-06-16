import 'package:firebase_auth/firebase_auth.dart';
import 'package:uevents/domain/accessLevel.dart';
import 'package:uevents/services/database.dart';
import 'access.dart';

class User {
  String id;
  String name;
  String email;
  Access access;

  User(this.id, this.name);

  User.fromFirebase(FirebaseUser fUser){
    id = fUser.uid;
    name = fUser.displayName;
    email = fUser.email;
    access = Access(0);

    var userStream = DatabaseService().getUsersInfo();

    userStream.listen((List<User> userList) {
      print('Уровни доступа пользователей:');

      userList.forEach((element) { 
        if (id == element.id)
          access = element.access;
        print(element.name + ': ' + element.access.toString());
      });
    });
  }

  Map<String, dynamic> toMap(){
    return {
      "id" : id,
      "name" : name,
      "email" : email,
      "accessLevel": access.level
    };
  }

  User.fromJson(String uid, Map<String, dynamic> data){
    id = data['id'];
    name = data['name'];
    email = data['email'];
    if (access == null)
      access = Access(0);
    access.level = data['accessLevel'];
  }

  
}