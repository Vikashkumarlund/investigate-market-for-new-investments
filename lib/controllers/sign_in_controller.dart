// ignore_for_file: file_names, unused_field, body_might_complete_normally_nullable, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../utils/app-constant.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;

  //for password visibilty
  // var isPasswordVisible = false.obs;

  Future<UserCredential?> signInMethod(
      String userEmail, String userPassword) async {
    try {
      //EasyLoading.show(status: "Please wait");
      isLoading.value = true;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      // EasyLoading.dismiss();
      isLoading.value = false;
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e);
      isLoading.value = false;
      if (e.code == 'weak-password') {
        Get.snackbar(
          "Error",
          "$e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appScendoryColor,
          colorText: AppConstant.appTextColor,
        );
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          "Error",
          "$e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appScendoryColor,
          colorText: AppConstant.appTextColor,
        );
      } else if (e.code == 'user-not-found') {
        Get.snackbar(
          "Error",
          "$e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appScendoryColor,
          colorText: AppConstant.appTextColor,
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          "Error",
          "$e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appScendoryColor,
          colorText: AppConstant.appTextColor,
        );
      }
      Get.snackbar(
        "Error",
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appScendoryColor,
        colorText: AppConstant.appTextColor,
      );
    }
  }
}
