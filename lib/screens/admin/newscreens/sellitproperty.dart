import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../models/cars_model.dart';
import '../../../models/property_model.dart';
import '../../../utils/app-constant.dart';
import '../../Property/single_property_detail.dart';
import '../../Vehicles/single_vehicle_detail.dart';

class sellitproperty extends StatefulWidget {
  const sellitproperty({super.key});

  @override
  State<sellitproperty> createState() => _sellitcatState();
}

class _sellitcatState extends State<sellitproperty> {
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
          .where("type", isEqualTo: "property"),
          padding: const EdgeInsets.all(8.0),
          itemBuilder: (context, snapshot) {
            final user = snapshot.data();
            String id = snapshot.id;

            String name = "";
            String number = "0";
            late PropertyModel propertyModel;
            FirebaseFirestore.instance
                .collection('users')
                .where("uId", isEqualTo: user["sellerId"])
                .get().then((value) {
                  name = value.docs.first.data()['username'];
                  number = value.docs.first.data()['phone'];
                  propertyModel  = PropertyModel(
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

            return InkWell(
              onTap: (){
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
                              user['propertyType'],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              user['propertyCity'],
                              style: const TextStyle(),
                            ),
                            Text(
                              "property Area : ${user['propertyArea']}",
                              style: const TextStyle(),
                            ),
                            Text(
                              "property Price : ${user['propertyPrice']}",
                              style: const TextStyle(),
                            ),
                            Text(
                              "property Installment : ${user['propertyInstallment']}",
                              style: const TextStyle(),
                            ),
                            Text(
                              "property Title : ${user['propertyTitle']}",
                              style: const TextStyle(),
                            ),
                            Text(
                              "property Description : ${user['propertyDescription']}",
                              style: const TextStyle(),
                            ),
                            Text(
                              "property title : ${user['propertytitle']}",
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
