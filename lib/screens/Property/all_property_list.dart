// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp5/screens/Property/single_property_detail.dart';
import 'package:get/get.dart';

import '../../models/property_model.dart';
import '../../utils/app-constant.dart';
import '../../widgets/icon_and_text_widget.dart';

class propertiesListScreen extends StatefulWidget {
  const propertiesListScreen({super.key});

  @override
  State<propertiesListScreen> createState() => _propertiesListScreenState();
}

class _propertiesListScreenState extends State<propertiesListScreen> {
  @override
  Widget build(BuildContext context) {
    dynamic argumentData = Get.arguments;
    dynamic propertyType = argumentData[0]['type'];
    dynamic propertyLocation = argumentData[1]['Location'];
    dynamic propertyArea = argumentData[2]['area'];
    dynamic propertyMode = argumentData[3]['fourth'];
    String propertyModeString = propertyMode.toString();
    String area = "5 Marla";

    checkArea() {
      if (propertyArea == 1)
        area = "5 Marla";
      else if (propertyArea == 2)
        area = "8 Marla";
      else if (propertyArea == 3)
        area = "10 Marla";
      else
        area = "12 Marla";
    }

    if (propertyType != null &&
        propertyLocation == null &&
        propertyArea == null) {
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
                propertyType.toString(),
                style: TextStyle(color: AppConstant.appTextColor),
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('property')
                  .where('propertyType', isEqualTo: propertyType.toString())
                  .where('propertyMode', isEqualTo: propertyModeString)
                  .snapshots(),
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
                        String id = document[index].id;
                        PropertyModel propertyModel = PropertyModel(
                          sellerId: document['sellerId'],
                          imgUrl: document['imgUrl'],
                          propertyType: document['propertyType'],
                          propertyCity: document['propertyCity'],
                          propertyArea: document['propertyArea'],
                          propertyPrice: document['propertyPrice'],
                          propertyInstallment: document['propertyInstallment'],
                          propertyTitle: document['propertyTitle'],
                          propertyDescription: document['propertyDescription'],
                          propertySellerName: document['propertySellerName'],
                          propertySellerPhone: document['propertySellerPhone'],
                          propertyMode: document['propertyMode'],
                        );

                        return GestureDetector(
                            //You need to make my child interactive
                            onTap: () => Get.to(() =>
                                SinglePropertyDetailScreen(
                                  id: id,
                                    propertyModel: propertyModel)),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
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
                                            propertyModel.imgUrl,
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
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(propertyModel.propertyTitle),
                                            /*SizedBox(
                                              height: 5,
                                            ),
                                            Text(propertyModel.propertyPrice
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
                                                    text: propertyModel
                                                        .propertyCity,
                                                    iconColor:
                                                        Colors.greenAccent),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                IconAndTextWidget(
                                                    icon: Icons
                                                        .access_time_rounded,
                                                    text: propertyModel
                                                        .propertyArea
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
    } else if (propertyType == null &&
        propertyLocation != null &&
        propertyArea == null) {
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
                propertyLocation.toString(),
                style: TextStyle(color: AppConstant.appTextColor),
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('property')
                  .where('propertyCity', isEqualTo: propertyLocation.toString())
                  .where('propertyMode', isEqualTo: propertyModeString)
                  .snapshots(),
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
                        String id = document[index].id;
                        PropertyModel propertyModel = PropertyModel(
                          sellerId: document['sellerId'],
                          imgUrl: document['imgUrl'],
                          propertyType: document['propertyType'],
                          propertyCity: document['propertyCity'],
                          propertyArea: document['propertyArea'],
                          propertyPrice: document['propertyPrice'],
                          propertyInstallment: document['propertyInstallment'],
                          propertyTitle: document['propertyTitle'],
                          propertyDescription: document['propertyDescription'],
                          propertySellerName: document['propertySellerName'],
                          propertySellerPhone: document['propertySellerPhone'],
                          propertyMode: document['propertyMode'],
                        );

                        return new GestureDetector(
                            //You need to make my child interactive
                            onTap: () => Get.to(() =>
                                SinglePropertyDetailScreen(
                                  id: id,
                                    propertyModel: propertyModel)),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
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
                                            propertyModel.imgUrl,
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
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(propertyModel.propertyTitle),
                                            /*SizedBox(
                                              height: 5,
                                            ),
                                            Text(propertyModel.propertyPrice
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
                                                    text: propertyModel
                                                        .propertyCity,
                                                    iconColor:
                                                        Colors.greenAccent),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                IconAndTextWidget(
                                                    icon: Icons
                                                        .access_time_rounded,
                                                    text: propertyModel
                                                        .propertyArea
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
    } else if (propertyType == null &&
        propertyLocation == null &&
        propertyArea != null) {
      checkArea();
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
                "Properties",
                style: TextStyle(color: AppConstant.appTextColor),
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('property')
                  .where('propertyArea', isEqualTo: propertyArea.toString())
                  .where('propertyMode', isEqualTo: propertyModeString)
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
                        String id = document[index].id;
                        PropertyModel propertyModel = PropertyModel(
                          sellerId: document['sellerId'],
                          imgUrl: document['imgUrl'],
                          propertyType: document['propertyType'],
                          propertyCity: document['propertyCity'],
                          propertyArea: document['propertyArea'],
                          propertyPrice: document['propertyPrice'],
                          propertyInstallment: document['propertyInstallment'],
                          propertyTitle: document['propertyTitle'],
                          propertyDescription: document['propertyDescription'],
                          propertySellerName: document['propertySellerName'],
                          propertySellerPhone: document['propertySellerPhone'],
                          propertyMode: document['propertyMode'],
                        );

                        return new GestureDetector(
                            //You need to make my child interactive
                            onTap: () => Get.to(() =>
                                SinglePropertyDetailScreen(
                                    id: id,
                                    propertyModel: propertyModel)),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
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
                                            propertyModel.imgUrl,
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
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(propertyModel.propertyTitle),
                                            /*SizedBox(
                                              height: 5,
                                            ),
                                            Text(propertyModel.propertyPrice
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
                                                    text: propertyModel
                                                        .propertyCity,
                                                    iconColor:
                                                        Colors.greenAccent),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                IconAndTextWidget(
                                                    icon: Icons
                                                        .access_time_rounded,
                                                    text: propertyModel
                                                        .propertyArea
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
                "Properties",
                style: TextStyle(color: AppConstant.appTextColor),
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('property')
                  .where('propertyMode', isEqualTo: propertyModeString)
                  .snapshots(),
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
                        String id = document[index].id;
                        PropertyModel propertyModel = PropertyModel(
                          sellerId: document['sellerId'],
                          imgUrl: document['imgUrl'],
                          propertyType: document['propertyType'],
                          propertyCity: document['propertyCity'],
                          propertyArea: document['propertyArea'],
                          propertyPrice: document['propertyPrice'],
                          propertyInstallment: document['propertyInstallment'],
                          propertyTitle: document['propertyTitle'],
                          propertyDescription: document['propertyDescription'],
                          propertySellerName: document['propertySellerName'],
                          propertySellerPhone: document['propertySellerPhone'],
                          propertyMode: document['propertyMode'],
                        );

                        return new GestureDetector(
                            //You need to make my child interactive
                            onTap: () => Get.to(() =>
                                SinglePropertyDetailScreen(
                                    id: id,
                                    propertyModel: propertyModel)),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
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
                                            propertyModel.imgUrl,
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
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(propertyModel.propertyTitle),
                                            /*SizedBox(
                                              height: 5,
                                            ),
                                            Text(propertyModel.propertyPrice
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
                                                    text: propertyModel
                                                        .propertyCity,
                                                    iconColor:
                                                        Colors.greenAccent),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                IconAndTextWidget(
                                                    icon: Icons
                                                        .access_time_rounded,
                                                    text: propertyModel
                                                        .propertyArea
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
