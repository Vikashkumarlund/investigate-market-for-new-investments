import 'package:fyp5/controllers/sign_in_controller.dart';
import 'package:fyp5/controllers/update_property_controller.dart';
import 'package:get/get.dart';

import '../controllers/Car_controller.dart';
import '../controllers/Property_controller.dart';
import '../controllers/sign_up_controller.dart';
import '../controllers/update_car_controller.dart';

Future<void> init() async {
  Get.lazyPut(() => SignUpController());
  Get.lazyPut(() => SignInController());
  Get.lazyPut(() => CarController());
  Get.lazyPut(() => PropertyController());
  Get.lazyPut(() => UpdateCarController());
  Get.lazyPut(() => UpdatePropertyController());
}
