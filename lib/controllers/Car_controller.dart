import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/cars_model.dart';
import '../utils/app-constant.dart';

class CarController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;

  Future<bool> addCar(
      String sellerId,
      String imgUrl,
      String carLocation,
      String carBrand,
      String carDesciption,
      String carSellerName,
      int carSellerPhone,
      int carDistance,
      int carPrice,
      String carMode,
      int carInstallment) async {
    try {
      //EasyLoading.show(status: "Please wait");
      isLoading.value = true;
      CarsModel carModel = CarsModel(
        sellerId: sellerId,
        imgUrl: imgUrl,
        carLocation: carLocation,
        carBrand: carBrand,
        carDesciption: carDesciption,
        carSellerName: carSellerName,
        carSellerPhone: carSellerPhone,
        carDistance: carDistance,
        carPrice: carPrice,
        carMode: carMode,
        carInstallment: carInstallment,
      );

      // add data into database
      final document = _firestore.collection('cars').add(carModel.toMap());
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
