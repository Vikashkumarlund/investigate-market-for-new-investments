import 'package:flutter/material.dart';
import 'package:fyp5/Navigation/nav_property.dart';
import 'package:fyp5/global/global.dart' as globals;
import 'package:fyp5/screens/Authentication/LogIn.dart';
import 'package:fyp5/screens/admin/adminchat.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Navigation/nav_vehicle.dart';
import '../screens/Property/Sell_Property.dart';
import '../screens/Property/update_delete_property.dart';
import '../screens/Vehicles/Sell_Vehicle.dart';
import '../screens/Vehicles/update_delete_Vehicle.dart';
import '../screens/admin/newscreens/chatting.dart';
import '../utils/app-constant.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        backgroundColor: AppConstant.appScendoryColor,
        child: Wrap(
          runSpacing: 10,
          children: [
            const Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Investigate Market",
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                subtitle: Text(
                  "For New Investments",
                  style: TextStyle(color: Colors.orange),
                ),
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppConstant.appMainColor,
                  child: Text(
                    "",
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
                ),
              ),
            ),
            const Divider(
              indent: 10.0,
              endIndent: 10.0,
              thickness: 1.5,
              color: Colors.grey,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Home",
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                leading: Icon(
                  Icons.home,
                  color: AppConstant.appTextColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConstant.appTextColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () {
                  setState(() {
                    globals.check = "vehicle";
                    globals.navCheck = "vehicle";
                  });
                  Get.to(() => NavVehicle());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text(
                  "Vehicle Finder",
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                leading: const Icon(
                  Icons.production_quantity_limits,
                  color: AppConstant.appTextColor,
                ),
                trailing: const Icon(
                  Icons.arrow_forward,
                  color: AppConstant.appTextColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () {
                  setState(() {
                    globals.check = "property";
                    globals.navCheck = "property";
                  });
                  Get.to(() => NavProperty());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text(
                  "Property Finder",
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                leading: const Icon(
                  Icons.production_quantity_limits,
                  color: AppConstant.appTextColor,
                ),
                trailing: const Icon(
                  Icons.arrow_forward,
                  color: AppConstant.appTextColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const adminchat(isadmin: false,);
                  }));
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text(
                  "Admin Chat",
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                leading: const Icon(
                  Icons.chat,
                  color: AppConstant.appTextColor,
                ),
                trailing: const Icon(
                  Icons.arrow_forward,
                  color: AppConstant.appTextColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () {
                  //RestartWidget.restartApp(context);
                  if (globals.check == "vehicle") {
                    Get.to(() => const UpdateDeleteVehicle());
                  } else {
                    Get.to(() => const UpdateDeleteProperty());
                  }
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text(
                  "My Ads",
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                leading: const Icon(
                  Icons.shopping_bag,
                  color: AppConstant.appTextColor,
                ),
                trailing: const Icon(
                  Icons.arrow_forward,
                  color: AppConstant.appTextColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () {
                  if (globals.check == "vehicle") {
                    Get.to(() => const SellVehicleScreen());
                  } else {
                    Get.to(() => const SellPropertyScreen());
                  }
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text(
                  "Post Ads",
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                leading: const Icon(
                  Icons.help,
                  color: AppConstant.appTextColor,
                ),
                trailing: const Icon(
                  Icons.arrow_forward,
                  color: AppConstant.appTextColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('email');
                  Get.to(const LoginScreen());
                },
                // onTap: () async {
                //GoogleSignIn googleSignIn = GoogleSignIn();
                //  FirebaseAuth _auth = FirebaseAuth.instance;
                //  await _auth.signOut();
                // await googleSignIn.signOut();
                // Get.offAll(() => SplashScreen());
                // },
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text(
                  "Logout",
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                leading: const Icon(
                  Icons.logout,
                  color: AppConstant.appTextColor,
                ),
                trailing: const Icon(
                  Icons.arrow_forward,
                  color: AppConstant.appTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
