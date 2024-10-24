import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constants/utils.dart';
import '../../Providers/SplashProvider.dart';
import '../Onboarding/OnbordingScreen.dart';
import 'SplashScreenbody.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    final splashScreenProvider = Provider.of<SplashScreenProvider>(context);

    splashScreenProvider.addListener(() {
      if (!splashScreenProvider.isLoading) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, Onboarding.routeName);
        });
      }
    });
    return Scaffold(
      body: SplashBody(),
    );
  }
}
