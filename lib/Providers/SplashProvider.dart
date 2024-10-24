import 'package:flutter/material.dart';

class SplashScreenProvider with ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  SplashScreenProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(Duration(seconds: 4));
    _isLoading = false;
    notifyListeners();
  }
}
