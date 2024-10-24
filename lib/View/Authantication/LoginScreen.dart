import 'package:flutter/material.dart';

import 'LoginScreenBody.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static String routeName = "/login";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreenBody(),
    );
  }
}