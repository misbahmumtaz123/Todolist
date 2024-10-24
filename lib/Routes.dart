import 'package:flutter/material.dart';
import 'View/Authantication/LoginScreen.dart';
import 'View/Onboarding/OnbordingScreen.dart';
import 'View/Splash/SplashScreen.dart';
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) =>  SplashScreen(),
  Onboarding.routeName: (context) => Onboarding(),
  LoginScreen.routeName:(context)=> LoginScreen(),
};
