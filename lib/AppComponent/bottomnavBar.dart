import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:todolistt/View/Calendar/CalendarScreen.dart';

import '../../Constants/utils.dart';
import '../View/AddTask/AddTaskScreen.dart';
import '../View/Profile/ProfileScreen.dart';
import '../generated/assets.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 1; // Default to AddTaskScreen

  final List<String> _titles = [
    'Calendar Screen',
    'Add Task',
    'Profile',
  ];

  final List<Widget> _screens = [
    CalendarScreen(),
    AddTaskScreen(),
    ProfileScreen(),

  ];

  final List<Widget> _items = [
    SvgPicture.asset(
      Assets.imagesNotify,
      color: Colors.white,
      height: 30,
    ),
    Image.asset(
      'Assets/Images/plus.png',
      height: 30,
      color: Colors.white,
    ),
    SvgPicture.asset(
      Assets.imagesProfile,
      color: Colors.white,
      height: 30,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 1) {
          setState(() {
            _currentIndex = 1;
          });
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_titles[_currentIndex]),
          backgroundColor: AppColors.PrimaryColor,
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: AppColors.SecondaryColor,
          buttonBackgroundColor: AppColors.PrimaryColor,
          height: 60,
          items: _items,
          index: _currentIndex,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        body: _screens[_currentIndex],
      ),
    );
  }
}