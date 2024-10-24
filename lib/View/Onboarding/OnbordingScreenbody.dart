import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../../AppComponent/custombutton.dart';
import '../../Constants/string.dart';
import '../../Constants/utils.dart';
import '../../generated/assets.dart';
import '../Authantication/LoginScreen.dart';

class OnboardingBody extends StatefulWidget {
  const OnboardingBody({Key? key}) : super(key: key);

  @override
  State<OnboardingBody> createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<OnboardingBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        // globalBackgroundColor: AppColors.BGColor,
        pages: [
          PageViewModel(
            title: title,
            body: 'Welcome to TODO! Your personal task manager to simplify life.'
                ' Effortlessly add, organize, and complete your to-dos—stay.'
                ' Productive and make every day count!',
            image: Image.asset(
              Assets.imagesOnbording1,
              fit: BoxFit.cover,
            ),
          ),
          PageViewModel(
            title: title,
            body: 'Create multiple to-do lists, add '
                'tasks with due dates and priorities, and track your progress effortlessly. ',
            image: Image.asset(
              Assets.imagesOnbording2,
              fit: BoxFit.cover,
            ),
          ),
          PageViewModel(
            title: title,
            body: 'Stay on top of your tasks with reminders and '
                'notifications. Boost your productivity and achieve your goals with MyTasks. ',
            image: Image.asset(
              Assets.imagesOnbording3,
              fit: BoxFit.cover,
            ),
          ),
        ],
        showBackButton: false,
        showNextButton: true,
        showSkipButton: true,
        skip: MyTextButton(
          name: 'Skip',
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );

          },

        ),
        next: const Icon(
          Icons.arrow_forward,
          color: AppColors.PrimaryColor,
          size: 30,
        ),
        done: const Text(
          'Continue',
          style: TextStyle(
            fontSize: 17,
            color: AppColors.PrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        onDone: () {
          Navigator.pushNamed(context, LoginScreen.routeName);
        },
        dotsDecorator: DotsDecorator(
          size: const Size(10, 15),
          activeColor: AppColors.PrimaryColor,
          activeSize: const Size(10, 15),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
      ),
    );
  }
}

