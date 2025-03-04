import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Authentication {
  static Future<User?> signInAnonymously() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      final UserCredential userCredential = await auth.signInAnonymously();
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Failed to sign in anonymously: $e');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to sign in anonymously: $e');
      }
    }

    return user;
  }
}
