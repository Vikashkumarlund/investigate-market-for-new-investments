import 'package:flutter/material.dart';
import 'package:fyp5/global/global.dart' as globals;
import 'package:get/get.dart';

import '../models/carousel.dart';
import '../service/banner_service.dart';
import '../service/property-banner-service.dart';

class CarouselController extends GetxController {
  static CarouselController instance = Get.find();
  RxList<CarouselModel> carouselItemList =
      List<CarouselModel>.empty(growable: true).obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    //getData();
  }

  void getData() async {
    try {
      isLoading(true);
      var result;
      if (globals.check == "property") {
        result = await PropertyBannerService().getBanners1();
      } else if (globals.check == "vehicle") {
        result = await BannerService().getBanners();
      }
      carouselItemList.clear();
      carouselItemList.addAll(result);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
