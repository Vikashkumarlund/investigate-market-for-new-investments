import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp5/Navigation/nav_vehicle.dart';
import 'package:fyp5/screens/Authentication/LogIn.dart';
import 'package:fyp5/screens/Authentication/Signup.dart';
import 'package:fyp5/screens/admin/adminhome.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<StatefulWidget> createState() => Initstate();
}

class Initstate extends State<SplashScreen> {
  @override
  void initState() {
    sharedPreferencesRoute();

    // TODO: implement initState
    super.initState();
  }

  startTimer() async {
    var duration = const Duration(seconds: 1);
    return Timer(duration, navigatetohome());
  }

  sharedPreferencesRoute() async {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      var email = prefs.getString('email');
      print(email);
      if (email == null) {
        //startTimer();
        navigatetohome();
      } else if (email == "admin@gmail.com") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const adminhome()));
      } else {
        Get.to(NavVehicle());
      }
    });
  }

  signupRoute() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  navigatetohome() {
    // await Future.delayed(const Duration(milliseconds: 2000), (() {}));

    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get()
        .then((DocumentSnapshot documentsnapshot) {
      if (documentsnapshot.exists) {
        Get.to(() => const LoginScreen());
      } else {
        Get.to(() => const SignUpScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 250,
              width: 250,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/investor.png"),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          /*Center(
            child: Container(
                height: 200,
                width: 200,
                child: Image.asset("assets/investor.png")),
          )*/
        ],
      ),
    );
  }
}
