import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/user-model.dart';
import '../utils/app-constant.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;

  Future<UserCredential?> signup(
    String userEmail,
    String userPassword,
    String userName,
    String userPhone,
    String userAddress,
  ) async {
    try {
      //EasyLoading.show(status: "Please wait");
      isLoading.value = true;
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: userEmail, password: userPassword);

      // send email verification
      await userCredential.user!.sendEmailVerification();

      //authprofilesetting(userCredential, userName, userPhone);
      /* final user = FirebaseAuth.instance.currentUser!;
          final docuser =
          FirebaseFirestore.instance.collection('Users').doc(user.uid);*/

      UserModel userModel = UserModel(
        uId: userCredential.user!.uid,
        username: userName,
        email: userEmail,
        phone: userPhone,
        userAddress: '',
        isAdmin: "false",
        userpassword: userPassword,
        status: "inactive",
      );
      // add data into database
      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());
      // EasyLoading.dismiss();
      isLoading.value = false;
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // EasyLoading.dismiss();
      isLoading.value = false;
      Get.snackbar(
        "Error",
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appScendoryColor,
        colorText: AppConstant.appTextColor,
      );
    }
  }

  Future authprofilesetting(
      UserCredential cred, String name, String contact) async {
    await cred.user?.updateDisplayName(name);
    await cred.user?.updatePhoneNumber(contact as PhoneAuthCredential);
    // await cred.user?.updatePhotoURL(
    //     'https://firebasestorage.googleapis.com/v0/b/pc-builder-2c0a4.appspot.com/o/DisplayPicture%2Fdefaultimage.jpg?alt=media&token=af41bdaf-f5f4-4f0d-ad96-78734f8eb73a');
  }
}
