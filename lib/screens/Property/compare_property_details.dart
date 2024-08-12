import 'package:flutter/material.dart';

import '../../models/property_model.dart';
import '../../utils/app-constant.dart';

class ComparePropertyDetails extends StatefulWidget {
  PropertyModel propertyModel1, propertyModel2;

  ComparePropertyDetails(
      {super.key, required this.propertyModel1, required this.propertyModel2});

  @override
  State<ComparePropertyDetails> createState() => _ComparePropertyState();
}

class _ComparePropertyState extends State<ComparePropertyDetails> {
  /* Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Two ListViews Side by Side'),
        ),
        body: Center(
          child: Row(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('List 1 Item $index'),
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    color: tappedIndex == index ? Colors.blue : Colors.grey,
                    return ListTile(
                      title: Text('List 2 Item $index'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }*/
  /*late int tappedIndex;

  @override
  void initState() {
    super.initState();
    tappedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                    color: tappedIndex == index ? Colors.blue : Colors.grey,
                    child: ListTile(
                        title: Center(
                          child: Text('${index + 1}'),
                        ),
                        onTap: () {
                          setState(() {
                            tappedIndex = index;
                          });
                        }));
              })
        ]));
  }*/

  String propertySpecs1 = "";
  String propertySpecs2 = "";
  @override
  void initState() {
    if (widget.propertyModel1.propertyMode == "Sell") {
      propertySpecs1 =
          "Price:" + widget.propertyModel1.propertyPrice.toString();
    } else {
      propertySpecs1 =
          "Rent:" + widget.propertyModel1.propertyInstallment.toString();
    }
    if (widget.propertyModel2.propertyMode == "Sell") {
      propertySpecs2 =
          "Price:" + widget.propertyModel2.propertyPrice.toString();
    } else {
      propertySpecs2 =
          "Rent:" + widget.propertyModel2.propertyInstallment.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: AppConstant.appTextColor),
          backgroundColor: AppConstant.appMainColor,
          title: Text(
            "Property Comparison",
            style: TextStyle(color: AppConstant.appTextColor),
          )),
      body: Column(
        children: [
          //Vehicle Image
          Container(
            height: 220,
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(90)),
                gradient: LinearGradient(
                    colors: [(new Color(0xffF5591F)), (new Color(0xffF2861E))],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width / 5,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          widget.propertyModel1.imgUrl,
                        ),
                      ),
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width / 5,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          widget.propertyModel2.imgUrl,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // Icon(Icons.title, color: Colors.orange),
                                          Text(
                                              "Type:" +
                                                  widget.propertyModel1
                                                      .propertyType,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.blue,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          //Icon(Icons.home, color: Colors.orange),
                                          Text(
                                              "Location:" +
                                                  widget.propertyModel1
                                                      .propertyCity,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          //Icon(Icons.location_city,color: Colors.orange),
                                          Text(
                                              'Mode:' +
                                                  widget.propertyModel1
                                                      .propertyMode,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          //  Icon(Icons.location_city,color: Colors.orange),
                                          Text(propertySpecs1,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          //Icon(Icons.price_change,color: Colors.orange,),
                                          Text(
                                              "Area:" +
                                                  widget.propertyModel1
                                                      .propertyArea,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          //Icon(Icons.price_change,color: Colors.orange,),
                                          Text(
                                              "Title:" +
                                                  widget.propertyModel1
                                                      .propertyTitle,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          //Icon(Icons.price_change,color: Colors.orange,),
                                          Text(
                                              "Desciption:" +
                                                  widget.propertyModel1
                                                      .propertyDescription,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(color: Colors.orange),
                          Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // Icon(Icons.title, color: Colors.orange),
                                          Text(
                                              "Type:" +
                                                  widget.propertyModel2
                                                      .propertyType,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.blue,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          //Icon(Icons.home, color: Colors.orange),
                                          Text(
                                              "Location:" +
                                                  widget.propertyModel2
                                                      .propertyCity,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          //Icon(Icons.location_city,color: Colors.orange),
                                          Text(
                                              'Mode:' +
                                                  widget.propertyModel2
                                                      .propertyMode,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          //  Icon(Icons.location_city,color: Colors.orange),
                                          Text(propertySpecs2,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          //Icon(Icons.price_change,color: Colors.orange,),
                                          Text(
                                              "Area:" +
                                                  widget.propertyModel2
                                                      .propertyArea,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          //Icon(Icons.price_change,color: Colors.orange,),
                                          Text(
                                              "Title:" +
                                                  widget.propertyModel2
                                                      .propertyTitle,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          //Icon(Icons.price_change,color: Colors.orange,),
                                          Text(
                                              "Desciption:" +
                                                  widget.propertyModel2
                                                      .propertyDescription,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
