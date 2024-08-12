import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/property_model.dart';
import '../../widgets/icon_and_text_widget.dart';
import 'compare_property_details.dart';

class ComparePropertyScreen extends StatefulWidget {
  const ComparePropertyScreen({super.key});

  @override
  State<ComparePropertyScreen> createState() => _CompareProperty();
}

class _CompareProperty extends State<ComparePropertyScreen> {
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

  late PropertyModel propertyModel1;
  late PropertyModel propertyModel2;

  @override
  void initState() {
    super.initState();
    tappedIndex = 0;
    tappedIndex1 = 0;
    user = FirebaseAuth.instance.currentUser;
    _collectionRef = FirebaseFirestore.instance.collection('property');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Compare Properties"),
          actions: <Widget>[
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  onPressed: () {
                    if (propertyModel1 != null && propertyModel2 != null) {
                      Get.to(() => ComparePropertyDetails(
                          propertyModel1: propertyModel1,
                          propertyModel2: propertyModel2));
                    }
                  },
                  icon: Icon(Icons.compare_sharp),
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
                        width: MediaQuery.of(context).size.width * .4,
                        child: ListView.builder(
                          controller: ScrollController(keepScrollOffset: true),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot document = documents[index];

                            PropertyModel propertyModel11 = PropertyModel(
                              sellerId: document['sellerId'],
                              imgUrl: document['imgUrl'],
                              propertyType: document['propertyType'],
                              propertyCity: document['propertyCity'],
                              propertyArea: document['propertyArea'],
                              propertyPrice: document['propertyPrice'],
                              propertyInstallment:
                              document['propertyInstallment'],
                              propertyTitle: document['propertyTitle'],
                              propertyDescription:
                              document['propertyDescription'],
                              propertySellerName:
                              document['propertySellerName'],
                              propertySellerPhone:
                              document['propertySellerPhone'],
                              propertyMode: document['propertyMode'],
                            );

                            return GestureDetector(
                              //You need to make my child interactive
                                onTap: () => setState(() {
                                  tappedIndex = index;
                                  propertyModel1 = propertyModel11;
                                }),
                                child: Container(
                                  color: tappedIndex == index
                                      ? Colors.red
                                      : Colors.white,
                                  margin: EdgeInsets.only(
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
                                                  propertyModel11.propertyType,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(propertyModel11
                                                    .propertyArea
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
                                                        text: propertyModel11
                                                            .propertyCity,
                                                        iconColor:
                                                        Colors.orange),
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
                StreamBuilder<QuerySnapshot>(
                  stream: _collectionRef.snapshots(),
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
                        width: MediaQuery.of(context).size.width * .4,
                        child: ListView.builder(
                          controller: ScrollController(keepScrollOffset: true),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot document = documents[index];
                            PropertyModel propertyModel21 = PropertyModel(
                              sellerId: document['sellerId'],
                              imgUrl: document['imgUrl'],
                              propertyType: document['propertyType'],
                              propertyCity: document['propertyCity'],
                              propertyArea: document['propertyArea'],
                              propertyPrice: document['propertyPrice'],
                              propertyInstallment:
                              document['propertyInstallment'],
                              propertyTitle: document['propertyTitle'],
                              propertyDescription:
                              document['propertyDescription'],
                              propertySellerName:
                              document['propertySellerName'],
                              propertySellerPhone:
                              document['propertySellerPhone'],
                              propertyMode: document['propertyMode'],
                            );

                            return GestureDetector(
                              //You need to make my child interactive
                                onTap: () => setState(() {
                                  tappedIndex1 = index;
                                  propertyModel2 = propertyModel21;
                                }),
                                child: Container(
                                  color: tappedIndex1 == index
                                      ? Colors.red
                                      : Colors.white,
                                  margin: EdgeInsets.only(
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
                                                  propertyModel21.propertyType,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(propertyModel21
                                                    .propertyArea
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
                                                        text: propertyModel21
                                                            .propertyCity,
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
