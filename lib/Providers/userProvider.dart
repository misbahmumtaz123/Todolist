
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  UserProvider() {
    _loadUser();
  }

  Future<void> _loadUser() async {
    _user = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }
}
