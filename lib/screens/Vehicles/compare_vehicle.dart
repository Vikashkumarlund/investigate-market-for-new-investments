import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/cars_model.dart';
import '../../widgets/icon_and_text_widget.dart';
import 'compare_vehicle_details.dart';

class CompareVehicleScreen extends StatefulWidget {
  const CompareVehicleScreen({super.key});

  @override
  State<CompareVehicleScreen> createState() => _CompareVehicle();
}

class _CompareVehicle extends State<CompareVehicleScreen> {
  /*var options_location = [
    'Lahore',
    'Peshawar',
    'Islamabad',
    'Karachi',
    'Sahiwal',
    'Sialkot',
  ];
  var _currentItemSelectedLocation = "Lahore";
  var rool = "Investor";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown Menus'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('cars').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 60,
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200],
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 5,
                        color: Color(0xffEEEEEE))
                  ],
                ),
                alignment: Alignment.topLeft,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(
                    Icons.location_city,
                    color: Color(0xffF5591F),
                  ),
                  DropdownButton<String>(
                    dropdownColor: Colors.white70,
                    isDense: true,
                    isExpanded: false,
                    iconEnabledColor: Colors.white,
                    focusColor: Colors.white,
                    items: options_location.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(
                          dropDownStringItem,
                          style: const TextStyle(
                            color: Colors.black87,
                            // fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValueSelected) {
                      setState(() {
                        _currentItemSelectedLocation = newValueSelected!;
                        rool = newValueSelected;
                      });
                    },
                    value: _currentItemSelectedLocation,
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.deepOrange,
                    ),
                  ),
                ]),
              ),
              Container(
                height: 60,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200],
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 5,
                        color: Color(0xffEEEEEE))
                  ],
                ),
                alignment: Alignment.center,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(
                    Icons.location_city,
                    color: Color(0xffF5591F),
                  ),
                  DropdownButton<String>(
                    dropdownColor: Colors.white70,
                    isDense: true,
                    isExpanded: false,
                    iconEnabledColor: Colors.white,
                    focusColor: Colors.white,
                    items: options_location.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(
                          dropDownStringItem,
                          style: const TextStyle(
                            color: Colors.black87,
                            // fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValueSelected) {
                      setState(() {
                        _currentItemSelectedLocation = newValueSelected!;
                        rool = newValueSelected;
                      });
                    },
                    value: _currentItemSelectedLocation,
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.deepOrange,
                    ),
                  ),
                ]),
              ),
            ],
          );
          return Container();
        },
      ),
    );
  }*/

  User? user = FirebaseAuth.instance.currentUser;
  late CollectionReference _collectionRef;
  late int tappedIndex;
  late int tappedIndex1;

  late CarsModel carsModel1;
  late CarsModel carsModel2;

  @override
  void initState() {
    super.initState();
    tappedIndex = 0;
    tappedIndex1 = 0;
    user = FirebaseAuth.instance.currentUser;
    _collectionRef = FirebaseFirestore.instance.collection('cars');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Compare Vehicles"),
          actions: <Widget>[
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  onPressed: () {
                    Get.to(() => CompareVehicleDetails(
                        carsModel1: carsModel1, carsModel2: carsModel2));
                    //Scaffold.of(context).showSnackBar(snackBar);
                  },
                  icon: const Icon(Icons.compare_sharp),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: _collectionRef.snapshots(),
                  //FirebaseFirestore.instance.collection('categories').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Error"),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        height: 50,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    List<DocumentSnapshot> documents = snapshot.data!.docs;

                    return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width * .4,
                        child: ListView.builder(
                          controller: ScrollController(keepScrollOffset: true),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot document = documents[index];
                            CarsModel carsModel11 = CarsModel(
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
                                onTap: () => setState(() {
                                      tappedIndex = index;
                                      carsModel1 = carsModel11;
                                    }),
                                child: Container(
                                  color: tappedIndex == index
                                      ? Colors.red
                                      : Colors.white,
                                  margin: const EdgeInsets.only(
                                      left: 2, right: 2, bottom: 10),
                                  child: Row(
                                    children: [
                                      //text container
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            //color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 1, right: 1),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  carsModel11.carBrand,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(carsModel11.carPrice
                                                    .toString()
                                                    .toString()),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(carsModel11.carLocation
                                                    .toString()
                                                    .toString()),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(carsModel11.carDesciption
                                                    .toString()
                                                    .toString()),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(carsModel11.carSellerName
                                                    .toString(),style: const TextStyle(fontWeight: FontWeight.bold),),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(DateTime.now().toString().substring(0,10)
                                                  ,style: const TextStyle(fontWeight: FontWeight.bold),),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    IconAndTextWidget(
                                                        icon: Icons.location_on,
                                                        text: carsModel11
                                                            .carLocation,
                                                        iconColor:
                                                            Colors.orange),
                                                    /*SizedBox(
                                                      width: 5,
                                                    ),
                                                    IconAndTextWidget(
                                                        icon: Icons
                                                            .access_time_rounded,
                                                        text: carsModel
                                                            .carDistance
                                                            .toString(),
                                                        iconColor:
                                                            Colors.orange),*/
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      /*Expanded(
                                        child: Container(
                                          color: tappedIndex == index
                                              ? Colors.blue
                                              : Colors.grey,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 1, right: 1),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  carsModel.carBrand,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87,
                                                  ),
                                                ),
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
                                                        text: carsModel
                                                            .carLocation,
                                                        iconColor:
                                                            Colors.orange),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    IconAndTextWidget(
                                                        icon: Icons
                                                            .access_time_rounded,
                                                        text: carsModel
                                                            .carDistance
                                                            .toString(),
                                                        iconColor:
                                                            Colors.orange),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),*/
                                    ],
                                  ),
                                ));
                          }, //item Builder
                        ));
                    return Container();
                  },
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: _collectionRef.snapshots(),
                  //FirebaseFirestore.instance.collection('categories').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Error"),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        height: 50,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    List<DocumentSnapshot> documents = snapshot.data!.docs;

                    return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width * .4,
                        child: ListView.builder(
                          controller: ScrollController(keepScrollOffset: true),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot document = documents[index];
                            CarsModel carsModel21 = CarsModel(
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
                                onTap: () => setState(() {
                                      tappedIndex1 = index;
                                      carsModel2 = carsModel21;
                                    }),
                                child: Container(
                                  color: tappedIndex1 == index
                                      ? Colors.red
                                      : Colors.white,
                                  margin: const EdgeInsets.only(
                                      left: 2, right: 2, bottom: 10),
                                  child: Row(
                                    children: [
                                      //text container
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            //color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 1, right: 1),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  carsModel21.carBrand,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(carsModel21.carPrice
                                                    .toString()
                                                    .toString()),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(carsModel21.carLocation
                                                    .toString()
                                                    .toString()),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(carsModel21.carDesciption
                                                    .toString()
                                                    .toString()),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(carsModel21.carSellerName
                                                    .toString(),style: const TextStyle(fontWeight: FontWeight.bold),),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(DateTime.now().toString().substring(0,10)
                                                  ,style: const TextStyle(fontWeight: FontWeight.bold),),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    IconAndTextWidget(
                                                        icon: Icons.location_on,
                                                        text: carsModel21
                                                            .carLocation,
                                                        iconColor:
                                                            Colors.orange),
                                                    /*SizedBox(
                                                      width: 5,
                                                    ),
                                                    IconAndTextWidget(
                                                        icon: Icons
                                                            .access_time_rounded,
                                                        text: carsModel
                                                            .carDistance
                                                            .toString(),
                                                        iconColor:
                                                            Colors.orange),*/
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
              ],
            ),
          ),
        ));
  }
}
