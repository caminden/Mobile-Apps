import 'package:firebase_auth/firebase_auth.dart';

class FireBaseController{
  static Future login(String email, String password) async {
    UserCredential cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email, 
      password: password,
      );
      return cred;
  }
  
}