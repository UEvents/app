import 'package:firebase_auth/firebase_auth.dart';

class User {
  String id;
  String name;
  String email;

  User(this.id, this.name);

  User.fromFirebase(FirebaseUser fUser){
    id = fUser.uid;
    name = fUser.displayName;
    email = fUser.email;
  }
}