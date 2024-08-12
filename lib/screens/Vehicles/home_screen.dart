import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp5/global/global.dart' as globals;
import 'package:fyp5/screens/Vehicles/single_vehicle_detail.dart';
import 'package:fyp5/screens/admin/newscreens/sellitcat.dart';
import 'package:get/get.dart';

import '../../Repository/SearchItems.dart';
import '../../controllers/carousel_controller.dart';
import '../../models/cars_model.dart';
import '../../utils/app-constant.dart';
import '../../widgets/custom-drawer-widget.dart';
import '../../widgets/heading-widget.dart';
import '../Authentication/LogIn.dart';
import 'SearchCarPage.dart';
import 'categories_list_screen.dart';
import 'compare_vehicle.dart';
import 'slider_screen_vehicle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() => Home();
}

class Home extends State<HomeScreen> {
  var a = Get.put(CarouselController());
  FirebaseAuth auth = FirebaseAuth.instance;
  String mode = "Sell";
  Color buttonSellColor = Colors.red;
  Color buttonRentColor = Colors.transparent;
  signOut() async {
    await auth.signOut();
  }

  //toggle price option
  bool containerPriceVisible = true;

  void toggleContainerVisibility() {
    if (mode == "Sell") {
      setState(() {
        containerPriceVisible = true;
      });
    } else {
      setState(() {
        containerPriceVisible = false;
      });
    }
  }

  @override
  void initState() {
    globals.check = "vehicle";
    a.getData();
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
                  showSearch(context: context, delegate: CarSearch());
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          drawer: const DrawerWidget(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SliderScreenVehicle(),
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
                              toggleContainerVisibility();
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
                              toggleContainerVisibility();
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
                            Get.to(() => const CompareVehicleScreen());
                          },
                        ),
                      ]),
                ),
                // CategoriesWidget(),
                HeadingWidget(
                  headingTitle: "Sell IT FOR ME",
                  headingSubTitle: "All Items are approved by admin",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const sellitcat()));
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
                    .where("type", isEqualTo: "car"),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(8.0),
                    itemBuilder: (context, snapshot) {
                      final user = snapshot.data();
                      String id = snapshot.id;
                      return InkWell(
                        onTap: () async {
                          String name = "";
                          String number = "0";
                          late CarsModel carsModel;
                          await FirebaseFirestore.instance
                              .collection('users')
                              .where("uId", isEqualTo: user["sellerId"])
                              .get()
                              .then((value) {
                            name = value.docs.first.data()['username'];
                            number = value.docs.first.data()['phone'];
                            carsModel = CarsModel(
                              sellerId: user['sellerId'].toString(),
                              imgUrl: user['imgUrl'].toString(),
                              carLocation: user['carLocation'].toString(),
                              carBrand: user['carBrand'].toString(),
                              carDesciption: user['carDesciption'].toString(),
                              carSellerName: name,
                              carSellerPhone: int.parse(number),
                              carDistance: user['carDistance'] ?? 0,
                              carPrice: user['carPrice'] ?? 0,
                              carMode: user['carMode'].toString(),
                              carInstallment: user['carInstallment'] ?? 0,
                            );
                          });
                          Get.to(() => SingleVehicleDetailsScreen(
                                carsModel: carsModel,
                            id: id,
                              ));
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
                                    user['carBrand'],
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

                //heading ..According to Brand selection
                HeadingWidget(
                  headingTitle: "Brands",
                  headingSubTitle: "Select According to Brands",
                  onTap: () =>
                      Get.to(() => const CategoriesScreen(), arguments: [
                    {"first": null},
                    {"second": null},
                    {"third": null},
                    {"fourth": mode}
                  ]),
                  buttonText: "See More >",
                ), //..According to Brand selection

                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: brandsDetails.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          //You need to make my child
                          onTap: () => Get.to(() => const CategoriesScreen(),
                                  arguments: [
                                    {
                                      "first":
                                          brandsDetails[index].title.toString()
                                    },
                                    {"second": null},
                                    {"third": null},
                                    {"fourth": mode}
                                  ]),
                          child: Container(
                              alignment: Alignment.center,
                              width: 100,
                              height: 100,
                              color: Colors.transparent,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
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
                                            Container(
                                              height: 60.0,
                                              width: 60.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage('assets/' +
                                                      brandsDetails[index]
                                                          .imgName
                                                          .toString()),
                                                  fit: BoxFit.cover,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                            ),

                                            const SizedBox(
                                              height: 10,
                                            ), //SizedBox
                                            Text(
                                              brandsDetails[index]
                                                  .title
                                                  .toString(),
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
                      Get.to(() => const CategoriesScreen(), arguments: [
                    {"first": null},
                    {"second": null},
                    {"third": null},
                    {"fourth": mode}
                  ]),
                  buttonText: "See More >",
                ),
                //According to cities
                /* StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('categories')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return Text('Something went wrong');
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Text("Loading");
                    List<DocumentSnapshot> documents = snapshot.data!.docs;
                    return */
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: citiesDetails.length,
                    itemBuilder: (BuildContext context, int index) {
                      /*DocumentSnapshot document = documents[index];
                      CategoriesModel categoriesModel = CategoriesModel(
                        categoryId: document['categoryId'],
                        categoryImg: document['categoryImg'],
                        categoryName: document['categoryName'],
                        createdAt: document['createdAt'],
                        updatedAt: document['updatedAt'],
                      );*/
                      return new GestureDetector(
                        //You need to make my child interactive
                        onTap: () =>
                            Get.to(() => const CategoriesScreen(), arguments: [
                          {"first": null},
                          {"second": citiesDetails[index].title.toString()},
                          {"third": null},
                          {"fourth": mode}
                        ]),
                        child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 100,
                            color: Colors.transparent,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
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
                                          Container(
                                            height: 60.0,
                                            width: 60.0,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage('assets/' +
                                                    citiesDetails[index]
                                                        .imgName
                                                        .toString()),
                                                fit: BoxFit.cover,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          /* CachedNetworkImage(
                                            imageUrl:
                                                categoriesModel.categoryImg,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              width: 60.0,
                                              height: 60.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),*/

                                          const SizedBox(
                                            height: 10,
                                          ), //SizedBox
                                          Text(
                                            citiesDetails[index]
                                                .title
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ), //Textstyle
                                          ),
                                        ], //children
                                      ),
                                    )))),
                      );
                    }, //itembuilder
                  ),
                ),
                /*  },),*/
                //According to price/Budget
                Visibility(
                    visible: containerPriceVisible,
                    child: HeadingWidget(
                      headingTitle: "Budget",
                      headingSubTitle: "According to your budget",
                      onTap: () =>
                          Get.to(() => const CategoriesScreen(), arguments: [
                        {"first": null},
                        {"second": null},
                        {"third": null}
                      ]),
                      buttonText: "See More >",
                    )),
                //According to budget
                /* StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('categories')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return Text('Something went wrong');
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Text("Loading");
                    List<DocumentSnapshot> documents = snapshot.data!.docs;*/
                Visibility(
                    visible: containerPriceVisible,
                    child: SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: pricesDetails.length,
                        itemBuilder: (BuildContext context, int index) {
                          /* DocumentSnapshot document = documents[index];
                          CategoriesModel categoriesModel = CategoriesModel(
                            categoryId: document['categoryId'],
                            categoryImg: document['categoryImg'],
                            categoryName: document['categoryName'],
                            createdAt: document['createdAt'],
                            updatedAt: document['updatedAt'],
                          );*/
                          return GestureDetector(
                            //You need to make my child interactive
                            onTap: () => Get.to(() => const CategoriesScreen(),
                                arguments: [
                                  {"first": null},
                                  {"second": null},
                                  {
                                    "third":
                                        pricesDetails[index].title.toString(),
                                  },
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
                                              Container(
                                                height: 60.0,
                                                width: 60.0,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/' +
                                                            pricesDetails[index]
                                                                .imgName
                                                                .toString()),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              /* CachedNetworkImage(
                                                imageUrl: categoriesModel
                                                    .categoryImg,
                                                imageBuilder: (context,
                                                        imageProvider) =>
                                                    Container(
                                                  width: 60.0,
                                                  height: 60.0,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),*/
                                              /* CircleAvatar(
                            backgroundColor: Colors.green[500],
                              radius: 50,
                              child: const CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://media.geeksforgeeks.org/wp-content/uploads/20210101144014/gfglogo.png"), //NetworkImage
                                radius: 50,
                              ), //CircleAvatar
                            ), */ //CircleAvatar
                                              const SizedBox(
                                                height: 10,
                                              ), //SizedBox
                                              Text(
                                                pricesDetails[index]
                                                    .title
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ), //Textstyle
                                              ),
                                            ], //children
                                          ),
                                        )))),
                          );
                        }, //itembuilder
                      ),
                    )),
                /* },
                ),*/
              ],
            ),
          ),
        ));
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
}
