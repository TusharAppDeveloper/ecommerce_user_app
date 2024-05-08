import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user_app/db/db_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/app_user_model.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;
  static String get uid => _auth.currentUser!.uid;



  static Future<void> loginUser(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> registerUser(String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final appUser = AppUserModel(
      email: cred.user!.email!,
      uid: cred.user!.uid,
      userCreationTime: Timestamp.fromDate(cred.user!.metadata.creationTime!)

    );
    return DbHelper().addNewUser(appUser);
  }

  static Future<void> logout() {
    return _auth.signOut();
  }
}
