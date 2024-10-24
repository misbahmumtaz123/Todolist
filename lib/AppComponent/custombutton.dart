import 'package:flutter/material.dart'
    '';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Constants/utils.dart';


class MyButton extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const MyButton({
    Key? key,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.PrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: onTap,
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.White,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
//use on onbording screen
class MyTextButton extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const MyTextButton({
    Key? key,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 17,
          color: AppColors.PrimaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class MyButtonLong extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  final Color? color;

  const MyButtonLong({
    Key? key,
    required this.name,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 55,
        width: Get.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? AppColors.PrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: onTap,
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double width;
  final double height;

  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.SecondaryColor,
            AppColors.SecondaryColor,
            AppColors.PrimaryColor,
            // AppColors.primaryColor,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          padding: EdgeInsets.zero,
        ),
        child: child,
      ),
    );
  }
}
