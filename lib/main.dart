// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
// // import 'Constants/utils.dart';
// import 'Providers/SplashProvider.dart';
// import 'Providers/authScreenProvider.dart';
// import 'Providers/bottombarProvider.dart';
// import 'Providers/todoprovider.dart';
// import 'Providers/userProvider.dart';
// import 'Routes.dart';
// import 'View/Splash/SplashScreen.dart';
// import 'firebase_options.dart';
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   FirebaseFirestore.instance.settings= const Settings(
//       persistenceEnabled: true
//   );
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Sizer(
//       builder: (context, orientation, deviceType) {
//         return MultiProvider(
//           providers: [
//             ChangeNotifierProvider(create: (_) => TodoProvider()),
//             ChangeNotifierProvider(create: (_) => SplashScreenProvider()),
//             ChangeNotifierProvider(create: (_) => BottomNavProvider()),
//             ChangeNotifierProvider(create: (_) => AuthProvider()),
//             ChangeNotifierProvider(create: (_) => UserProvider()),
//           ],
//           child: MaterialApp(
//             debugShowCheckedModeBanner: false,
//             initialRoute: SplashScreen.routeName,
//             routes: routes,
//             // theme: ThemeData(
//             //   primaryColor: AppColors.brightLemon,
//             //   scaffoldBackgroundColor: AppColors.brightLemon,
//             // ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Providers/SplashProvider.dart';
import 'Providers/authScreenProvider.dart';
import 'Providers/bottombarProvider.dart';
import 'Providers/todoprovider.dart';
import 'Providers/userProvider.dart';
import 'Routes.dart';
import 'View/Splash/SplashScreen.dart';
import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Request notification permission (for Android 13+)
  await requestNotificationPermission();

  // Initialize WorkManager for background tasks
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  // Initialize local notifications plugin
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());
}

// Request notification permission
Future<void> requestNotificationPermission() async {
  if (await Permission.notification.request().isGranted) {
    print('Notification permission granted');
  } else {
    print('Notification permission denied');
  }
}

// Callback function for WorkManager tasks
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == 'scheduleNotification') {
      final String taskTitle = inputData?['title'] ?? 'Task Reminder';
      final String taskDescription = inputData?['description'] ?? 'You have a task due now!';

      // Show notification when the task is triggered
      await flutterLocalNotificationsPlugin.show(
        0,
        taskTitle,
        taskDescription,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'task_channel',
            'Task Notifications',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
    }
    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => TodoProvider()),
            ChangeNotifierProvider(create: (_) => SplashScreenProvider()),
            ChangeNotifierProvider(create: (_) => BottomNavProvider()),
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => UserProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: SplashScreen.routeName,
            routes: routes,
          ),
        );
      },
    );
  }
}
