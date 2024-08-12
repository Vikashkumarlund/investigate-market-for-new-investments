import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp5/screens/Vehicles/home_screen.dart';
import 'package:fyp5/splash_screen.dart';
import 'package:fyp5/widgets/restart_app.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'helper/dependencies.dart' as dep;

//global object for accessing device screen size
late Size mq;
late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    // name: 'FlutterPropertyVehicle',
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    //appleProvider: AppleProvider.appAttest,
  );

  runApp(
    RestartWidget(child: MyApp()),
  );
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'BeGrow',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),

        home: SplashScreen());
    //home: HomeScreen());
  }
}


// class ErrorScreen extends StatelessWidget {
//   const ErrorScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         title: const Text("Error Screen"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => Get.to(() => HomeScreen()),
//           child: const Text("Go to home page"),
//         ),
//       ),
//     );

