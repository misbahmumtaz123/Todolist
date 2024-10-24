import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../View/AddTask/AddTaskScreen.dart';
import '../View/Authantication/LoginScreen.dart';
class AuthProvider extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final googleAccount = await _googleSignIn.signIn();
      if (googleAccount == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Sign-in canceled by user"),
        ));
        return;
      }

      final googleAuth = await googleAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user != null) {
        Navigator.pushNamedAndRemoveUntil(
            context,
            AddTaskScreen.routeName,
                (route) => false
        );
      }
    } on FirebaseAuthException catch (error) {
      print('FirebaseAuthException: ${error.message}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message ?? "Something went wrong"),
      ));
    } on Exception catch (e) {
      print('Exception: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("An unexpected error occurred: $e"),
      ));
    } catch (e) {
      print('Unknown error: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("An unknown error occurred"),
      ));
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();


      Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.routeName,
              (route) => false
      );
    } on FirebaseAuthException catch (error) {
      print('FirebaseAuthException: ${error.message}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message ?? "Error signing out"),
      ));
    } catch (e) {
      print('Unknown error: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("An unknown error occurred"),
      ));
    }
  }
}