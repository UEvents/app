import 'package:firebase_auth/firebase_auth.dart';

class User{
  String id;
  String name;
  String email;

  User.fromFirebase(FirebaseUser fUser){
    id = fUser.uid;
    email = fUser.email;
  }
}