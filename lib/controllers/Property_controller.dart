import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/property_model.dart';
import '../utils/app-constant.dart';

class PropertyController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;

  Future<bool> addProperty(
      String sellerId,
      String imgUrl,
      String propertyType,
      String propertyCity,
      String propertyArea,
      int propertyPrice,
      int propertyInstallment,
      String propertyTitle,
      String propertyDescription,
      String propertySellerName,
      int propertySellerPhone,
      String propertyMode) async {
    try {
      //EasyLoading.show(status: "Please wait");
      isLoading.value = true;
      PropertyModel propertyModel = PropertyModel(
        sellerId: sellerId,
        imgUrl: imgUrl,
        propertyType: propertyType,
        propertyCity: propertyCity,
        propertyArea: propertyArea,
        propertyPrice: propertyPrice,
        propertyInstallment: propertyInstallment,
        propertyTitle: propertyTitle,
        propertyDescription: propertyDescription,
        propertySellerName: propertySellerName,
        propertySellerPhone: propertySellerPhone,
        propertyMode: propertyMode,
      );

      // add data into database
      final document =
          _firestore.collection('property').add(propertyModel.toMap());
      //EasyLoading.dismiss();
      isLoading.value = false;
      return true;
    } on FirebaseAuthException catch (e) {
      //EasyLoading.dismiss();
      isLoading.value = false;
      Get.snackbar(
        "Error",
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appScendoryColor,
        colorText: AppConstant.appTextColor,
      );
      return false;
    }
  }
}
