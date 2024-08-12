import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../models/property_model.dart';
import '../../utils/app-constant.dart';
import '../../widgets/icon_and_text_widget.dart';

String firstBtn = "House";
String secondBtn = "Flat";
String thirdBtn = "Farm House";
String selectedType = "House";

var options_location = [
  'Lahore',
  'Peshawar',
  'Islamabad',
  'Karachi',
  'Sahiwal',
  'Sialkot',
];
var options_brand = [
  '5 Marla',
  '8 Marla',
  '10 Marla',
  '12 Marla',
];
var _currentItemSelectedLocation = "Lahore";
var _currentItemSelectedArea = "5 Marla";
RangeValues value = RangeValues(0, 10000000);

bool isVisible = true;
bool isVisibleResult = false;

class SearchProperty extends StatefulWidget {
  @override
  _SearchPropertyState createState() => _SearchPropertyState();
}

class _SearchPropertyState extends State<SearchProperty> {
  @override
  initState() {
    setState(() {
      isVisible = true;
      isVisibleResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppConstant.appScendoryColor,
            statusBarIconBrightness: Brightness.light),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          "Apply Filter for Property",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
              child: Column(children: [
        SizedBox(
          height: Get.height / 60,
        ),
        if (isVisible) ...[
          Container(
              child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Choose Property Type : ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 8, right: 2, top: 20),
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              alignment: Alignment.center,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(),
                  icon: Icon(
                    Icons.home,
                    color: Color(0xffF5591F),
                    size: 20,
                  ),
                  label: Text(
                    "Home",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      firstBtn = "Home";
                      secondBtn = "Flat";
                      thirdBtn = "Farm";
                    });
                  },
                ),
                SizedBox(
                  width: 6,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200]),
                  icon: Icon(
                    Icons.build_sharp,
                    color: Color(0xffF5591F),
                    size: 20,
                  ),
                  label: Text(
                    "Plot",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    setState(() {
                      firstBtn = "Residential";
                      secondBtn = "Commercial";
                      thirdBtn = "Agricultural";
                    });
                  },
                ),
                SizedBox(
                  width: 6,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200]),
                  icon: Icon(
                    Icons.tour_rounded,
                    color: Color(0xffF5591F),
                    size: 20,
                  ),
                  label: Text(
                    "Commercial",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    setState(() {
                      firstBtn = "Office";
                      secondBtn = "Shop";
                      thirdBtn = "Factory";
                    });
                  },
                ),
              ]),
            ),
            //Select the type of property
            // Sub Types of property
            Divider(color: Color(0xffF5591F)),
            Container(
              margin: const EdgeInsets.only(left: 8, right: 2),
              padding: const EdgeInsets.only(top: 3, bottom: 3),
              alignment: Alignment.center,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200]),
                  icon: Icon(
                    Icons.home,
                    color: Color(0xffF5591F),
                    size: 20,
                  ),
                  label: Text(
                    firstBtn,
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    selectedType = firstBtn.toString();
                  },
                ),
                SizedBox(
                  width: 6,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200]),
                  icon: Icon(
                    Icons.build_sharp,
                    color: Color(0xffF5591F),
                    size: 20,
                  ),
                  label: Text(
                    secondBtn,
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    selectedType = secondBtn.toString();
                  },
                ),
                SizedBox(
                  width: 6,
                ),
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(left: 8, right: 2, bottom: 10),
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              alignment: Alignment.center,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                  width: 1,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200]),
                  icon: Icon(
                    Icons.ac_unit_rounded,
                    color: Color(0xffF5591F),
                    size: 20,
                  ),
                  label: Text(
                    thirdBtn,
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    selectedType = thirdBtn.toString();
                  },
                ),
              ]),
            ),
            //Location
            Divider(color: Color(0xffF5591F)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Choose Property Location : ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 30, bottom: 20),
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE))
                ],
              ),
              alignment: Alignment.centerLeft,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Icon(
                  Icons.location_city,
                  color: Color(0xffF5591F),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Location: ",
                  style: TextStyle(
                    fontSize: 20,
                    // fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
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
            Divider(color: Color(0xffF5591F)),
            //Area
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Choose Property Area: ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE))
                ],
              ),
              alignment: Alignment.center,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Icon(
                  Icons.branding_watermark,
                  color: Color(0xffF5591F),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Area Size: ",
                  style: TextStyle(
                    fontSize: 20,
                    // fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  dropdownColor: Colors.white70,
                  isDense: true,
                  isExpanded: false,
                  iconEnabledColor: Colors.white,
                  focusColor: Colors.white,
                  items: options_brand.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(
                        dropDownStringItem,
                        style: const TextStyle(
                          color: Colors.black87,
                          // fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValueSelected) {
                    setState(() {
                      _currentItemSelectedArea = newValueSelected!;
                    });
                  },
                  value: _currentItemSelectedArea,
                  icon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.deepOrange,
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(color: Color(0xffF5591F)),
            //Price Range Text
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Choose Price Range : ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            //Price
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
                //padding: const EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.topRight,
                child: RangeSlider(
                    activeColor: Color(0xffF5591F),
                    inactiveColor: Colors.black,
                    values: value,
                    labels: RangeLabels(
                        '${value.start.round()}', '${value.end.round()}'),
                    divisions: 50,
                    min: 0,
                    max: 10000000,
                    onChanged: (newValue) {
                      setState(() {
                        value = newValue;
                        print(
                            '${value.start.toString()},${value.end.toString()}');
                      });
                    })),
            Divider(color: Color(0xffF5591F)),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 12),
              //padding: const EdgeInsets.only(left: 20, right: 20),

              alignment: Alignment.center,
              child: ElevatedButton(
                child: Text(
                  "Search Property",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                ),
                onPressed: () {
                  setState(() {
                    isVisible = false;
                    isVisibleResult = true;
                  });
                },
              ),
            ),
          ]))
        ],
        if (isVisibleResult) ...[
          Container(
              child: Column(children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('property')
                  .where('propertyType', isEqualTo: selectedType)
                  .where('propertyCity',
                      isEqualTo: _currentItemSelectedLocation)
                  .where('propertyArea', isEqualTo: _currentItemSelectedArea)
                  .where('propertyPrice', isGreaterThanOrEqualTo: value.start)
                  .where('propertyPrice', isLessThanOrEqualTo: value.end)
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
                            child: Container(
                          margin:
                              EdgeInsets.only(left: 20, right: 20, bottom: 10),
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
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(propertyModel.propertyTitle),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(propertyModel.propertyPrice
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
                                                text:
                                                    propertyModel.propertyCity,
                                                iconColor: Colors.greenAccent),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            IconAndTextWidget(
                                                icon: Icons.access_time_rounded,
                                                text: propertyModel.propertyArea
                                                    .toString(),
                                                iconColor: Colors.greenAccent),
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
            )
          ]))
        ],
      ]))),
    );
  }
}
