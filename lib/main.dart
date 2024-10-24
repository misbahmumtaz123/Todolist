import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
// import 'Constants/utils.dart';
import 'Providers/SplashProvider.dart';
import 'Providers/authScreenProvider.dart';
import 'Providers/bottombarProvider.dart';
import 'Providers/todoprovider.dart';
import 'Providers/userProvider.dart';
import 'Routes.dart';
import 'View/Splash/SplashScreen.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
FirebaseFirestore.instance.settings= const Settings(
  persistenceEnabled: true
);
  runApp(const MyApp());
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
            // theme: ThemeData(
            //   primaryColor: AppColors.brightLemon,
            //   scaffoldBackgroundColor: AppColors.brightLemon,
            // ),
          ),
        );
      },
    );
  }
}
