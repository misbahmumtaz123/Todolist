import 'package:flutter/material.dart';

import 'AddTaskScreenBody.dart';
class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});
  static String routeName = '/AddTaskScreen  ';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AddTaskScreenBody(),
      
      ),
    );
  }
}