import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp5/global/global.dart' as globals;
import 'package:fyp5/models/property_model.dart';
import 'package:fyp5/screens/Property/single_property_detail.dart';
import 'package:fyp5/screens/Property/slider_screen_property.dart';
import 'package:get/get.dart';

import '../../controllers/carousel_controller.dart';
import '../../models/PropertyListModel.dart';
import '../../utils/app-constant.dart';
import '../../widgets/custom-drawer-widget.dart';
import '../../widgets/heading-widget.dart';
import '../Authentication/LogIn.dart';
import '../admin/newscreens/sellitproperty.dart';
import 'SearchProperty.dart';
import 'all_property_list.dart';
import 'compare_property.dart';

class HomePropertyScreen extends StatefulWidget {
  const HomePropertyScreen({super.key});
  @override
  State<StatefulWidget> createState() => HomeProperty();
}

class HomeProperty extends State<HomePropertyScreen> {
  var a = Get.put(CarouselController());
  String mode = "Sell";
  Color buttonSellColor = Colors.red;
  Color buttonRentColor = Colors.transparent;
  FirebaseAuth auth = FirebaseAuth.instance;

  List<PropertyListModel> typeList = [
    PropertyListModel(name: "House", imgName: "plots.jpg"),
    PropertyListModel(name: "Flat", imgName: "plots.jpg"),
    PropertyListModel(name: "Farm House", imgName: "commercial.jpeg"),
  ];

  List homeList = [
    PropertyListModel(name: "House", imgName: "plots.jpg"),
    PropertyListModel(name: "Flat", imgName: "plots.jpg"),
    PropertyListModel(name: "Farm House", imgName: "commercial.jpeg"),
  ];

  List plotList = [
    PropertyListModel(name: "Residential", imgName: "plots.jpg"),
    PropertyListModel(name: "Commercial", imgName: "plots.jpg"),
    PropertyListModel(name: "Agricultural", imgName: "commercial.jpeg"),
  ];

  List commercialList = [
    PropertyListModel(name: "Office", imgName: "plots.jpg"),
    PropertyListModel(name: "Shop", imgName: "plots.jpg"),
    PropertyListModel(name: "Factory", imgName: "commercial.jpeg"),
  ];

  List citiesList = [
    PropertyListModel(name: "Lahore", imgName: "Islamabad.jpg"),
    PropertyListModel(name: "Karachi", imgName: "Karachi.jpg"),
    PropertyListModel(name: "Sahiwal", imgName: "Sahiwal.jpg"),
    PropertyListModel(name: "Sialkot", imgName: "Peshawar.jpg"),
    PropertyListModel(name: "Peshawar", imgName: "Sahiwal.jpg"),
    PropertyListModel(name: "Islamabad", imgName: "Sahiwal.jpg"),
  ];

  List areaList = [
    PropertyListModel(name: "5 Marla", imgName: "plots.jpg"),
    PropertyListModel(name: "8 Marla", imgName: "plots.jpg"),
    PropertyListModel(name: "10 Marla", imgName: "commercial.jpeg"),
    PropertyListModel(name: "12 Marla", imgName: "plots.jpg"),
  ];

  @override
  initState() {
    globals.check = "property";
    a.getData();
  }

  signOut() async {
    await auth.signOut();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want Signout'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => {
                  signOut(),
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  ),
                },
                //SystemNavigator.pop(),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: AppConstant.appTextColor),
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: AppConstant.appScendoryColor,
                statusBarIconBrightness: Brightness.light),
            backgroundColor: AppConstant.appMainColor,
            title: Text(
              AppConstant.appMainName,
              style: const TextStyle(color: AppConstant.appTextColor),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(SearchProperty());
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          drawer: const DrawerWidget(),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  const SliderScreenProperty(),
                  // CategoriesWidget(),
                  Container(
                    margin: const EdgeInsets.only(left: 8, right: 2, top: 5),
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    alignment: Alignment.topLeft,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: buttonSellColor),
                            icon: const Icon(
                              Icons.sell,
                              color: Colors.orange,
                              size: 20,
                            ),
                            label: const Text(
                              "Sell",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              mode = "Sell";
                              setState(() {
                                buttonRentColor = Colors.transparent;
                                buttonSellColor = Colors.red;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: buttonRentColor),
                            icon: const Icon(
                              Icons.car_rental,
                              color: Colors.orange,
                              size: 20,
                            ),
                            label: const Text(
                              "Rent",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              mode = "Rent";
                              setState(() {
                                buttonRentColor = Colors.red;
                                buttonSellColor = Colors.transparent;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent),
                            icon: const Icon(
                              Icons.car_rental,
                              color: Colors.orange,
                              size: 20,
                            ),
                            label: const Text(
                              "Compare",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Get.to(() => const ComparePropertyScreen());
                            },
                          ),
                        ]),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Browse Properties: ",
                        style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8, right: 2, top: 5),
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    alignment: Alignment.topLeft,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[200]),
                            icon: const Icon(
                              Icons.home,
                              color: Colors.orange,
                              size: 20,
                            ),
                            label: const Text(
                              "Home",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              setState(() {
                                typeList = List.from(homeList);
                              });
                            },
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[200]),
                            icon: const Icon(
                              Icons.build_sharp,
                              color: Colors.orange,
                              size: 20,
                            ),
                            label: const Text(
                              "Plot",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              setState(() {
                                typeList = List.from(plotList);
                              });
                            },
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[200]),
                            icon: const Icon(
                              Icons.tour_rounded,
                              color: Colors.orange,
                              size: 20,
                            ),
                            label: const Text(
                              "Commercial",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              setState(() {
                                typeList = List.from(commercialList);
                              });
                            },
                          ),
                        ]),
                  ),
                  //Sub Types of property
                  const Divider(color: Colors.orange),
                  // CategoriesWidget(),
                  HeadingWidget(
                    headingTitle: "Sell IT FOR ME",
                    headingSubTitle: "All Items are approved by admin",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const sellitproperty()));
                    },
                    buttonText: "See More >",
                  ),
                  SizedBox(
                    height: 140,
                    width: double.infinity,
                    child: FirestoreListView(
                      query: FirebaseFirestore.instance
                          .collection("sellit")
                          .where("status", isEqualTo: "active")
                          .where("type", isEqualTo: "property"),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(8.0),
                      itemBuilder: (context, snapshot) {
                        final user = snapshot.data();
                        String id = snapshot.id;
                        return InkWell(
                          onTap: () async {
                            String name = "";
                            String number = "0";
                            late PropertyModel propertyModel;
                            await FirebaseFirestore.instance
                                .collection('users')
                                .where("uId", isEqualTo: user["sellerId"])
                                .get()
                                .then((value) {
                              name = value.docs.first.data()['username'];
                              number = value.docs.first.data()['phone'];
                              propertyModel = PropertyModel(
                                sellerId: user['sellerId'].toString(),
                                imgUrl: user['imgUrl'].toString(),
                                propertyType: user['propertyType'].toString(),
                                propertyCity: user['propertyCity'].toString(),
                                propertyArea: user['propertyArea'].toString(),
                                propertyPrice: user['propertyPrice']??0,
                                propertyInstallment: user['propertyInstallment']??0,
                                propertyTitle: user['propertyTitle'].toString(),
                                propertyDescription: user['propertyDescription'].toString(),
                                propertySellerName: name,
                                propertySellerPhone: int.parse(number),
                                propertyMode: user['propertyMode'].toString(),
                              );
                            });
                            Get.to(() =>
                                SinglePropertyDetailScreen(
                                    propertyModel: propertyModel,id: id,));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xffF5591F).withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(
                                      3, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          user["imgUrl"],
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                        )),
                                    Text(
                                      user['propertyType'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                Positioned(
                                    child: Image.asset(
                                      "assets/approved.png",
                                      width: 20,
                                      height: 20,
                                    ))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  //heading ..According to Type selection
                  HeadingWidget(
                    headingTitle: "Type",
                    headingSubTitle: "Select According to Type",
                    onTap: () =>
                        Get.to(() => const propertiesListScreen(), arguments: [
                      {"type": null},
                      {"Location": null},
                      {"area": null},
                      {"fourth": mode}
                    ]),
                    buttonText: "See More >",
                  ), //..According to Type selection
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: typeList.length,
                      itemBuilder: (BuildContext context, int index) {
                        // DocumentSnapshot document = documents[index];
                        return new GestureDetector(
                            //You need to make my child
                            onTap: () => {
                                  Get.to(() => const propertiesListScreen(),
                                      arguments: [
                                        {"type": typeList[index].name},
                                        {"Location": null},
                                        {"area": null},
                                        {"fourth": mode}
                                      ]),
                                },
                            child: Container(
                                alignment: Alignment.center,
                                width: 100,
                                height: 100,
                                color: Colors.transparent,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Card(
                                    elevation: 10,
                                    //shadowColor: Colors.black,
                                    color: Colors.transparent,
                                    child: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/' +
                                                    typeList[index].imgName,
                                                fit: BoxFit.cover,
                                                width: 60.0,
                                                height: 60.0,
                                              ),

                                              const SizedBox(
                                                height: 10,
                                              ), //SizedBox
                                              Text(
                                                typeList[index].name,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ), //Textstyle
                                              ),
                                            ], //children
                                          ),
                                        )))));
                      }, //itembuilder
                    ),
                  ),

                  //According to cities
                  HeadingWidget(
                    headingTitle: "Cities",
                    headingSubTitle: "According to your Location",
                    onTap: () =>
                        Get.to(() => const propertiesListScreen(), arguments: [
                      {"type": null},
                      {"Location": null},
                      {"area": null},
                      {"fourth": mode}
                    ]),
                    buttonText: "See More >",
                  ),
                  //According to cities
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: citiesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        // DocumentSnapshot document = documents[index];
                        return new GestureDetector(
                            //You need to make my child
                            onTap: () => Get.to(() => const propertiesListScreen(),
                                    arguments: [
                                      {"type": null},
                                      {"Location": citiesList[index].name},
                                      {"area": null},
                                      {"fourth": mode}
                                    ]),
                            child: Container(
                                alignment: Alignment.center,
                                width: 100,
                                height: 100,
                                color: Colors.transparent,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Card(
                                    elevation: 10,
                                    //shadowColor: Colors.black,
                                    color: Colors.transparent,
                                    child: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/' +
                                                    citiesList[index].imgName,
                                                fit: BoxFit.cover,
                                                width: 60.0,
                                                height: 60.0,
                                              ),

                                              const SizedBox(
                                                height: 10,
                                              ), //SizedBox
                                              Text(
                                                citiesList[index].name,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ), //Textstyle
                                              ),
                                            ], //children
                                          ),
                                        )))));
                      }, //itembuilder
                    ),
                  ),
                  //According to Area
                  HeadingWidget(
                    headingTitle: "Land Area",
                    headingSubTitle: "According to the Land Area",
                    onTap: () =>
                        Get.to(() => const propertiesListScreen(), arguments: [
                      {"type": null},
                      {"Location": null},
                      {"area": null},
                      {"fourth": mode}
                    ]),
                    buttonText: "See More >",
                  ),
                  //According to budget
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: areaList.length,
                      itemBuilder: (BuildContext context, int index) {
                        // DocumentSnapshot document = documents[index];
                        return new GestureDetector(
                            //You need to make my child
                            onTap: () => Get.to(() => const propertiesListScreen(),
                                    arguments: [
                                      {"type": null},
                                      {"Location": null},
                                      {"area": areaList[index].name.toString()},
                                      {"fourth": mode}
                                    ]),
                            child: Container(
                                alignment: Alignment.center,
                                width: 100,
                                height: 100,
                                color: Colors.transparent,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Card(
                                    elevation: 10,
                                    //shadowColor: Colors.black,
                                    color: Colors.transparent,
                                    child: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/' +
                                                    areaList[index].imgName,
                                                fit: BoxFit.cover,
                                                width: 60.0,
                                                height: 60.0,
                                              ),

                                              const SizedBox(
                                                height: 10,
                                              ), //SizedBox
                                              Text(
                                                areaList[index].name,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ), //Textstyle
                                              ),
                                            ], //children
                                          ),
                                        )))));
                      }, //itembuilder
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
