import 'package:firebase_auth/firebase_auth.dart';

class AuthModel{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp({
    required String email,
    required String password
    }) async {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    }

}