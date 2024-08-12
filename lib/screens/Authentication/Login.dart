import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp5/screens/admin/adminhome.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../Navigation/nav_vehicle.dart';
import '../../controllers/sign_in_controller.dart';
import '../../main.dart';
import '../../utils/app-constant.dart';
import 'Forgot_Pass.dart';
import 'Signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => Initstate();
}

class Initstate extends State<LoginScreen> {
  SignInController signInController = Get.put(SignInController());

  final TextEditingController passcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    passcontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    signInController.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Container(
              height: 300,
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90)),
                  color: Color(0xffF5591F),
                  gradient: LinearGradient(
                    colors: [(Color(0xffF5591F)), (Color(0xffF2861E))],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      height: 150,
                      width: 150,
                      child: Image.asset("assets/investor.png"),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 40, top: 30),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "Welcome To Investigate on Investment Market",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE))
                ],
              ),
              alignment: Alignment.center,
              child: TextFormField(
                controller: emailcontroller,
                cursorColor: const Color(0xffF5591F),
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.email,
                    color: Color(0xffF5591F),
                  ),
                  hintText: "Enter Email",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.length == 0) {
                    return "Email cannot be empty";
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return ("Please enter a valid email");
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE))
                ],
              ),
              alignment: Alignment.center,
              child: TextFormField(
                  controller: passcontroller,
                  obscureText: true,
                  cursorColor: const Color(0xffF5591F),
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.vpn_key,
                      color: Color(0xffF5591F),
                    ),
                    hintText: "Enter Password",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  validator: (value) {
                    RegExp regex = new RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return "Password cannot be empty";
                    }
                    if (!regex.hasMatch(value)) {
                      return ("please enter valid password min. 6 character");
                    } else {
                      return null;
                    }
                  }),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, right: 20),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: const Text("Forget Password"),
                onTap: () => Get.to(const ForgetPassword()),
              ),
            ),
            Obx(
              () => ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: (const Color(0xffF5591F)),
                  fixedSize: const Size(300, 44),
                ),
                onPressed:
                    signInController.isLoading.value ? null : () => signin(),
                icon: signInController.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Icon(Icons.upload),
                label: Text(
                  signInController.isLoading.value ? 'Processing' : 'Login',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't Have Account? "),
                  GestureDetector(
                    onTap: () => Get.to(const SignUpScreen()),
                    child: const Text(
                      "Register Now",
                      style: TextStyle(color: Color(0xffF5591F)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  void clearStackAndNavigate(BuildContext context, String path) {
    while (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    }

    GoRouter.of(context).pushReplacement(path);
  }

  Future<void> signin() async {
    if (emailcontroller.text == "admin@gmail.com" &&
        passcontroller.text == "admin") {
      prefs.setString('email', emailcontroller.text);
      prefs.setString('uid', "admin");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const adminhome()));
      Get.snackbar(
        "Success Admin Login",
        "login Successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appScendoryColor,
        colorText: AppConstant.appTextColor,
      );
    } else {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) return;
      UserCredential? userCredential = await signInController.signInMethod(
          emailcontroller.text, passcontroller.text);

      if (userCredential != null) {
        if (userCredential.user!.emailVerified) {
          prefs.setString('email', emailcontroller.text);
          prefs.setString('uid', userCredential.user!.uid);

          FirebaseFirestore.instance
              .collection("users")
              .where("uId", isEqualTo: userCredential.user!.uid)
              .get()
              .then((value) {
            if (value.docs.first.data()['status'] == "active") {
              Get.offAll(() => NavVehicle());
              Get.snackbar(
                "Success User Login",
                "login Successfully!",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppConstant.appScendoryColor,
                colorText: AppConstant.appTextColor,
              );
            } else {
              Get.snackbar(
                "your are ${value.docs.first.data()['status']}",
                "wait for admin to active you",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppConstant.appScendoryColor,
                colorText: AppConstant.appTextColor,
              );
            }
          });
        } else {
          Get.snackbar(
            "Error",
            "Please verify your email before login",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppConstant.appScendoryColor,
            colorText: AppConstant.appTextColor,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Please try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appScendoryColor,
          colorText: AppConstant.appTextColor,
        );
      }
    }
  }
}
