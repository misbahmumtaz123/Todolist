import 'package:flutter/material.dart';

import 'OnbordingScreenbody.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});
  static String routeName = "/boarding";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingBody(),
    );
  }
}