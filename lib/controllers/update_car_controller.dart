import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/cars_model.dart';
import '../utils/app-constant.dart';

class UpdateCarController extends GetxController {
  var isLoading = false.obs;

  Future<bool> updateCar(
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
    int carInstallment,
    String id,
  ) async {
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

      // update data into database
      /* FirebaseFirestore.instance.collection('Cars').doc("docID").update({carModel
            "carBrand",
            carModel.carBrand,
            "carDesciption",
            carModel.carDesciption,
            "carDistance",
            carModel.carDistance,
            "carLocation",
            carModel.carLocation,
            "carPrice",
            carModel.carPrice,
            "carSellerName",
            carModel.carSellerName,
            "carSellerPhone",
            carModel.carSellerPhone,
            "imgUrl",
            carModel.imgUrl
          } */
      FirebaseFirestore.instance
          .collection('cars')
          .doc(id)
          .update(carModel.toMap());
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
