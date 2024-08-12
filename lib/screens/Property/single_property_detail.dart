// ignore_for_file: file_names, must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, unused_local_variable, avoid_print

import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/property_model.dart';
import '../../utils/app-constant.dart';
import '../Vehicles/single_vehicle_detail.dart';
import '../chat/chat_screen.dart';

class SinglePropertyDetailScreen extends StatefulWidget {
  PropertyModel propertyModel;
  String id;
  SinglePropertyDetailScreen({super.key, required this.propertyModel,required this.id});

  @override
  State<SinglePropertyDetailScreen> createState() =>
      _SinglePropertyDetailScreenState();
}

class _SinglePropertyDetailScreenState
    extends State<SinglePropertyDetailScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  String propertySpecs = "";
  @override
  void initState() {
    if (widget.propertyModel.propertyMode == "Sell") {
      propertySpecs =
          "  Property Price :  " + widget.propertyModel.propertyMode.toString();
    } else {
      propertySpecs = "  Property Rent :  " +
          widget.propertyModel.propertyInstallment.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    var list_name = [
      widget.propertyModel.imgUrl,
    ];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          widget.propertyModel.propertyType,
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        /*actions: [
          GestureDetector(
            onTap: () => Get.to(() => HomeScreen()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
        ],*/
      ),
      body: Container(
        child: ListView(
          children: [
            //product images

            SizedBox(
              height: Get.height / 60,
            ),
            CarouselSlider(
              items: list_name
                  .map(
                    (imageUrls) => ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: imageUrls,
                        fit: BoxFit.cover,
                        width: Get.width - 10,
                        placeholder: (context, url) => ColoredBox(
                          color: Colors.white,
                          child: Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                aspectRatio: 2.5,
                viewportFraction: 1,
              ),
            ),

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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.title, color: Colors.orange),
                            Text("  Prperty Name :  " +
                                widget.propertyModel.propertyTitle),
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
                            Icon(Icons.home, color: Colors.orange),
                            Text("  Property Type :  " +
                                widget.propertyModel.propertyType),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                          children: [
                            Icon(Icons.location_city, color: Colors.orange),
                            Text("  Property Location :  " +
                                widget.propertyModel.propertyCity),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.photo_size_select_actual,
                              color: Colors.orange,
                            ),
                            Text("  Property Area :  " +
                                widget.propertyModel.propertyArea),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.price_change,
                              color: Colors.orange,
                            ),
                            Text(propertySpecs),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              color: Colors.orange,
                            ),
                            Text(" Seller Information  :"),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.sell,
                              color: Colors.orange,
                            ),
                            Text("  Seller Name :  " +
                                widget.propertyModel.propertySellerName),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.orange,
                            ),
                            Text("  Seller Phone :  " +
                                widget.propertyModel.propertySellerPhone
                                    .toString()),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            child: Container(
                              width: Get.width / 3.0,
                              height: Get.height / 16,
                              decoration: BoxDecoration(
                                color: AppConstant.appScendoryColor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: TextButton(
                                child: Text(
                                  "Chat",
                                  style: TextStyle(
                                      color: AppConstant.appTextColor),
                                ),
                                onPressed: () {
                                  //for navigating to chat screen
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ChatScreen(
                                                userId: widget
                                                    .propertyModel.sellerId,
                                                sellerName: widget.propertyModel
                                                    .propertySellerName,
                                              )));
                                  /*Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ChatScreen(
                                              sellerId:
                                                  widget.propertyModel.sellerId,
                                              sellerName: widget.propertyModel
                                                  .propertySellerName)));*/
                                  // Get.to(() => SignInScreen());
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Material(
                            child: Container(
                              width: Get.width * 0.2,
                              height: Get.height / 16,
                              decoration: BoxDecoration(
                                color: AppConstant.appScendoryColor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: TextButton(
                                child: Text(
                                  "Rate It",
                                  style: TextStyle(
                                      color: AppConstant.appTextColor),
                                ),
                                onPressed: () => showdialog(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("review")
                  .where("uid",
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .where("adid", isEqualTo: widget.id)
                  .get(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List c = List.of(snapshot.data.docs);
                  return Column(
                    children: c
                        .map((e) => Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(
                                3, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e['review'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          AnimatedRatingStars(
                            initialRating: e['rating'],
                            minRating: 0.0,
                            maxRating: 5.0,
                            filledColor: Colors.amber,
                            emptyColor: Colors.grey,
                            filledIcon: Icons.star,
                            halfFilledIcon: Icons.star_half,
                            emptyIcon: Icons.star_border,
                            onChanged: (double rating) {},
                            displayRatingValue: true,
                            interactiveTooltips: true,
                            customFilledIcon: Icons.star,
                            customHalfFilledIcon: Icons.star_half,
                            customEmptyIcon: Icons.star_border,
                            starSize: 20,
                            animationDuration:
                            const Duration(milliseconds: 300),
                            animationCurve: Curves.easeInOut,
                            readOnly: true,
                          ),
                        ],
                      ),
                    ))
                        .toList(),
                  );
                } else if (snapshot.hasError) {
                  return const Icon(
                    Icons.error,
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void showdialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10.0),
                  color: Colors.white,
                  child: rating(
                    id: widget.id,
                  )));
        });
  }
}
