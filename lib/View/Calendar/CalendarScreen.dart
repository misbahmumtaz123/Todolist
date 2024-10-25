import 'package:flutter/material.dart';

import 'CalendarScreenBody.dart';
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});
  static String routeName = '/CalendarScreen ';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CalendarScreenBody(),

    );
  }
}