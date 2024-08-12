import 'package:flutter/material.dart';

import '../../models/cars_model.dart';
import '../../utils/app-constant.dart';

class CompareVehicleDetails extends StatefulWidget {
  CarsModel carsModel1, carsModel2;

  CompareVehicleDetails(
      {super.key, required this.carsModel1, required this.carsModel2});

  @override
  State<CompareVehicleDetails> createState() => _CompareVehicleState();
}

class _CompareVehicleState extends State<CompareVehicleDetails> {
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

  String carSpecs1 = "";
  String carSpecs2 = "";
  @override
  void initState() {
    if (widget.carsModel1.carMode == "Sell") {
      carSpecs1 = "Price:" + widget.carsModel1.carPrice.toString();
    } else {
      carSpecs1 = "Rent:" + widget.carsModel1.carInstallment.toString();
    }
    if (widget.carsModel2.carMode == "Sell") {
      carSpecs2 = "Price:" + widget.carsModel2.carPrice.toString();
    } else {
      carSpecs2 = "Rent:" + widget.carsModel2.carInstallment.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: AppConstant.appTextColor),
          backgroundColor: AppConstant.appMainColor,
          title: Text(
            "Vehicle Comparison",
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
                          widget.carsModel1.imgUrl,
                        ),
                      ),
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width / 5,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          widget.carsModel2.imgUrl,
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
                                              "Brand:" +
                                                  widget.carsModel1.carBrand,
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
                                                  widget.carsModel1.carLocation,
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
                                                  widget.carsModel1.carMode,
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
                                          Text(carSpecs1,
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
                                                  widget
                                                      .carsModel1.carDesciption,
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
                            padding: EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
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
                                              "Brand:" +
                                                  widget.carsModel2.carBrand,
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
                                                  widget.carsModel2.carLocation,
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
                                                  widget.carsModel2.carMode,
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
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          //Icon(Icons.location_city,color: Colors.orange),
                                          Text(carSpecs2,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          //Icon(Icons.price_change,color: Colors.orange,),
                                          Text(
                                              "Desciption:" +
                                                  widget
                                                      .carsModel2.carDesciption,
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
