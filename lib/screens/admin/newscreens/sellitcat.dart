import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../models/cars_model.dart';
import '../../../utils/app-constant.dart';
import '../../Vehicles/single_vehicle_detail.dart';

class sellitcat extends StatefulWidget {
  const sellitcat({super.key});

  @override
  State<sellitcat> createState() => _sellitcatState();
}

class _sellitcatState extends State<sellitcat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppConstant.appTextColor,
        ),
        backgroundColor: AppConstant.appMainColor,
        title: const Text(
          "All Categories",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FirestoreListView(
          query: FirebaseFirestore.instance
              .collection("sellit")
              .where("status", isEqualTo: "active")
          .where("type", isEqualTo: "car"),
          padding: const EdgeInsets.all(8.0),
          itemBuilder: (context, snapshot) {
            final user = snapshot.data();
            String id = snapshot.id;

            String name = "";
            String number = "0";
            late CarsModel carsModel;
            FirebaseFirestore.instance
                .collection('users')
                .where("uId", isEqualTo: user["sellerId"])
                .get().then((value) {
                  name = value.docs.first.data()['username'];
                  number = value.docs.first.data()['phone'];
                  carsModel  = CarsModel(
                    sellerId: user['sellerId'].toString(),
                    imgUrl: user['imgUrl'].toString(),
                    carLocation: user['carLocation'].toString(),
                    carBrand: user['carBrand'].toString(),
                    carDesciption: user['carDesciption'].toString(),
                    carSellerName: name,
                    carSellerPhone: int.parse(number),
                    carDistance: user['carDistance']??0,
                    carPrice: user['carPrice']??0,
                    carMode: user['carMode'].toString(),
                    carInstallment: user['carInstallment']??0,
                  );
                });

            return InkWell(
              onTap: (){
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
                      offset: const Offset(3, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .where("uId", isEqualTo: user["sellerId"])
                          .get(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          var user = snapshot.data!.docs[0].data();
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.amber.withOpacity(0.2),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name : ${user['username']}",
                                  style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Email : ${user['email']}",
                                  style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Icon(
                            Icons.error,
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                    Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              user["imgUrl"],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user['carBrand'],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              user['carDesciption'],
                              style: const TextStyle(),
                            ),
                            Text(
                              "Distance : ${user['carDistance']}",
                              style: const TextStyle(),
                            ),
                            Text(
                              "Price : ${user['carPrice']}",
                              style: const TextStyle(),
                            ),
                            Text(
                              "Car Mode : ${user['carMode']}",
                              style: const TextStyle(),
                            ),
                            Text(
                              "Installment : ${user['carInstallment']}",
                              style: const TextStyle(),
                            ),
                            Text(
                              "Location : ${user['carLocation']}",
                              style: const TextStyle(),
                            ),
                            Text(
                              user['propertyDescription'],
                              style: const TextStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
