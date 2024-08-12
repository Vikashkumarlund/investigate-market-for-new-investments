
import 'package:get/get.dart';

import '../controllers/carousel_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CarouselController());
  }
}