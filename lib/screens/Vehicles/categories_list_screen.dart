// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp5/screens/Vehicles/single_vehicle_detail.dart';
import 'package:get/get.dart';

import '../../models/cars_model.dart';
import '../../utils/app-constant.dart';
import '../../widgets/icon_and_text_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    dynamic argumentData = Get.arguments;
    dynamic carBrand = argumentData[0]['first'];
    dynamic carBrand1 = argumentData[1]['second'];
    dynamic carBrand2 = argumentData[2]['third'];
    dynamic carMode = argumentData[3]['fourth'];
    String carModeString = carMode.toString();
    String carBrand3 = carBrand2.toString();
    int greaterThan = 0;
    int lessThan = 0;

    selectRange() {
      if (carBrand3 == "first") {
        greaterThan = 500000;
        lessThan = 2000000;
      } else if (carBrand3 == "second") {
        greaterThan = 2000000;
        lessThan = 4000000;
      } else if (carBrand3 == "third") {
        greaterThan = 4000000;
        lessThan = 6000000;
      } else if (carBrand3 == "fourth") {
        greaterThan = 6000000;
        lessThan = 8000000;
      } else {
        greaterThan = 8000000;
        lessThan = 9000000;
      }
    }

    if (carBrand != null && carBrand1 == null && carBrand2 == null) {
      return WillPopScope(
          onWillPop: () async {
            Get.back();
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: AppConstant.appTextColor,
              ),
              backgroundColor: AppConstant.appMainColor,
              title: Text(
                "All Categories",
                style: TextStyle(color: AppConstant.appTextColor),
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('cars')
                  .where('carBrand', isEqualTo: carBrand.toString())
                  .where('carMode', isEqualTo: carModeString)
                  //.where('carLocation', isEqualTo: "Karachi")
                  //.where('carPrice', isGreaterThan: 100000)
                  .snapshots(),
              //FirebaseFirestore.instance.collection('categories').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                List<DocumentSnapshot> documents = snapshot.data!.docs;
                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot document = documents[index];
                        String id = documents[index].id;
                        CarsModel carsModel = CarsModel(
                          sellerId: document['sellerId'],
                          imgUrl: document['imgUrl'],
                          carLocation: document['carLocation'],
                          carBrand: document['carBrand'],
                          carDesciption: document['carDesciption'],
                          carSellerName: document['carSellerName'],
                          carSellerPhone: document['carSellerPhone'],
                          carDistance: document['carDistance'],
                          carPrice: document['carPrice'],
                          carMode: document['carMode'],
                          carInstallment: document['carInstallment'],
                        );

                        return GestureDetector(
                            //You need to make my child interactive
                            onTap: () =>
                                Get.to(() => SingleVehicleDetailsScreen(
                                      carsModel: carsModel,
                                  id: id,
                                    )),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 2, right: 2, bottom: 10),
                              child: Row(
                                children: [
                                  //image container
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white38,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            carsModel.imgUrl,
                                            // AppConstants.BASE_URL+AppConstants.MID_URL+productModel1.img!
                                          ),
                                        )),
                                  ),
                                  //text container
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 1, right: 1),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(carsModel.carBrand),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(carsModel.carPrice
                                                .toString()
                                                .toString()),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                IconAndTextWidget(
                                                    icon: Icons.location_on,
                                                    text: carsModel.carLocation,
                                                    iconColor:
                                                        Colors.greenAccent),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                IconAndTextWidget(
                                                    icon: Icons
                                                        .access_time_rounded,
                                                    text: carsModel.carDistance
                                                        .toString(),
                                                    iconColor:
                                                        Colors.greenAccent),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      }, //item Builder
                    ));
                return Container();
              },
            ),
          ));
    } else if (carBrand == null && carBrand1 != null && carBrand2 == null) {
      return WillPopScope(
          onWillPop: () async {
            Get.back();
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: AppConstant.appTextColor,
              ),
              backgroundColor: AppConstant.appMainColor,
              title: Text(
                carBrand1.toString(),
                style: TextStyle(color: AppConstant.appTextColor),
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('cars')
                  // .where('carBrand', isEqualTo: carBrand)
                  .where('carLocation', isEqualTo: carBrand1.toString())
                  .where('carMode', isEqualTo: carModeString)
                  // .where('carPrice', isGreaterThan: 100000)
                  .snapshots(),
              //FirebaseFirestore.instance.collection('categories').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                List<DocumentSnapshot> documents = snapshot.data!.docs;
                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot document = documents[index];
                        String id = documents[index].id;
                        CarsModel carsModel = CarsModel(
                          sellerId: document['sellerId'],
                          imgUrl: document['imgUrl'],
                          carLocation: document['carLocation'],
                          carBrand: document['carBrand'],
                          carDesciption: document['carDesciption'],
                          carSellerName: document['carSellerName'],
                          carSellerPhone: document['carSellerPhone'],
                          carDistance: document['carDistance'],
                          carPrice: document['carPrice'],
                          carMode: document['carMode'],
                          carInstallment: document['carInstallment'],
                        );

                        return GestureDetector(
                            //You need to make my child interactive
                            onTap: () =>
                                Get.to(() => SingleVehicleDetailsScreen(
                                      carsModel: carsModel,
                                      id: id,
                                    )),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 2, right: 2, bottom: 10),
                              child: Row(
                                children: [
                                  //image container
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white38,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            carsModel.imgUrl,
                                            // AppConstants.BASE_URL+AppConstants.MID_URL+productModel1.img!
                                          ),
                                        )),
                                  ),
                                  //text container
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 1, right: 1),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(carsModel.carBrand),
                                            /*SizedBox(
                                              height: 5,
                                            ),
                                            Text(carsModel.carPrice
                                                .toString()
                                                .toString()),*/
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                IconAndTextWidget(
                                                    icon: Icons.location_on,
                                                    text: carsModel.carLocation,
                                                    iconColor:
                                                        Colors.greenAccent),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                IconAndTextWidget(
                                                    icon: Icons
                                                        .access_time_rounded,
                                                    text: carsModel.carDistance
                                                        .toString(),
                                                    iconColor:
                                                        Colors.greenAccent),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      }, //item Builder
                    ));
                return Container();
              },
            ),
          ));
    } else if (carBrand == null && carBrand1 == null && carBrand2 != null) {
      selectRange();
      return WillPopScope(
          onWillPop: () async {
            Get.back();
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: AppConstant.appTextColor,
              ),
              backgroundColor: AppConstant.appMainColor,
              title: Text(
                carBrand1.toString(),
                style: TextStyle(color: AppConstant.appTextColor),
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('cars')
                  // .where('carBrand', isEqualTo: carBrand)
                  .where('carPrice', isLessThanOrEqualTo: lessThan)
                  .where('carPrice', isGreaterThanOrEqualTo: greaterThan)
                  .where('carMode', isEqualTo: carModeString)
                  .snapshots(),
              //FirebaseFirestore.instance.collection('categories').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                List<DocumentSnapshot> documents = snapshot.data!.docs;
                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot document = documents[index];
                        String id = documents[index].id;
                        CarsModel carsModel = CarsModel(
                          sellerId: document['sellerId'],
                          imgUrl: document['imgUrl'],
                          carLocation: document['carLocation'],
                          carBrand: document['carBrand'],
                          carDesciption: document['carDesciption'],
                          carSellerName: document['carSellerName'],
                          carSellerPhone: document['carSellerPhone'],
                          carDistance: document['carDistance'],
                          carPrice: document['carPrice'],
                          carMode: document['carMode'],
                          carInstallment: document['carInstallment'],
                        );

                        return GestureDetector(
                            //You need to make my child interactive
                            onTap: () =>
                                Get.to(() => SingleVehicleDetailsScreen(
                                      carsModel: carsModel,
                                      id: id,
                                    )),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 2, right: 2, bottom: 10),
                              child: Row(
                                children: [
                                  //image container
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white38,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            carsModel.imgUrl,
                                            // AppConstants.BASE_URL+AppConstants.MID_URL+productModel1.img!
                                          ),
                                        )),
                                  ),
                                  //text container
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 1, right: 1),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(carsModel.carBrand),
                                            /* SizedBox(
                                              height: 5,
                                            ),
                                            Text(carsModel.carPrice
                                                .toString()
                                                .toString()),*/
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                IconAndTextWidget(
                                                    icon: Icons.location_on,
                                                    text: carsModel.carLocation,
                                                    iconColor:
                                                        Colors.greenAccent),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                IconAndTextWidget(
                                                    icon: Icons
                                                        .access_time_rounded,
                                                    text: carsModel.carDistance
                                                        .toString(),
                                                    iconColor:
                                                        Colors.greenAccent),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      }, //item Builder
                    ));
                return Container();
              },
            ),
          ));
    } else {
      return WillPopScope(
          onWillPop: () async {
            Get.back();
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: AppConstant.appTextColor,
              ),
              backgroundColor: AppConstant.appMainColor,
              title: Text(
                "",
                style: TextStyle(color: AppConstant.appTextColor),
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('cars')
                  .where('carMode', isEqualTo: carModeString)
                  // .where('carBrand', isEqualTo: carBrand)
                  //   .where('carLocation', isEqualTo: carBrand1.toString())
                  //   .where('carPrice', isGreaterThan: 2000000)
                  .snapshots(),
              //FirebaseFirestore.instance.collection('categories').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                List<DocumentSnapshot> documents = snapshot.data!.docs;
                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot document = documents[index];
                        String id = documents[index].id;
                        CarsModel carsModel = CarsModel(
                          sellerId: document['sellerId'],
                          imgUrl: document['imgUrl'],
                          carLocation: document['carLocation'],
                          carBrand: document['carBrand'],
                          carDesciption: document['carDesciption'],
                          carSellerName: document['carSellerName'],
                          carSellerPhone: document['carSellerPhone'],
                          carDistance: document['carDistance'],
                          carPrice: document['carPrice'],
                          carMode: document['carMode'],
                          carInstallment: document['carInstallment'],
                        );

                        return GestureDetector(
                            //You need to make my child interactive
                            onTap: () =>
                                Get.to(() => SingleVehicleDetailsScreen(
                                      carsModel: carsModel,
                                      id: id,
                                    )),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 2, right: 2, bottom: 10),
                              child: Row(
                                children: [
                                  //image container
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white38,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            carsModel.imgUrl,
                                            // AppConstants.BASE_URL+AppConstants.MID_URL+productModel1.img!
                                          ),
                                        )),
                                  ),
                                  //text container
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 1, right: 1),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(carsModel.carBrand),
                                            /*SizedBox(
                                              height: 5,
                                            ),
                                            Text(carsModel.carPrice
                                                .toString()
                                                .toString()),*/
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                IconAndTextWidget(
                                                    icon: Icons.location_on,
                                                    text: carsModel.carLocation,
                                                    iconColor:
                                                        Colors.greenAccent),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                IconAndTextWidget(
                                                    icon: Icons
                                                        .access_time_rounded,
                                                    text: carsModel.carDistance
                                                        .toString(),
                                                    iconColor:
                                                        Colors.greenAccent),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      }, //item Builder
                    ));
                return Container();
              },
            ),
          ));
    }
  }
}
