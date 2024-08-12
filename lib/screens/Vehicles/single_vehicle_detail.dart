// ignore_for_file: file_names, must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, unused_local_variable, avoid_print

import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/cars_model.dart';
import '../../utils/app-constant.dart';
import '../chat/chat_screen.dart';

class SingleVehicleDetailsScreen extends StatefulWidget {
  CarsModel carsModel;
  String id;
  SingleVehicleDetailsScreen(
      {super.key, required this.carsModel, required this.id});

  @override
  State<SingleVehicleDetailsScreen> createState() =>
      _SingleVehicleDetailsScreenState();
}

class _SingleVehicleDetailsScreenState
    extends State<SingleVehicleDetailsScreen> {
  String carSpecs = "";
  @override
  void initState() {
    if (widget.carsModel.carMode == "Sell") {
      carSpecs = "  Vehicle Price :  " + widget.carsModel.carPrice.toString();
    } else {
      carSpecs =
          "  Vehicle Rent :  " + widget.carsModel.carInstallment.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    var listName = [
      widget.carsModel.imgUrl,
    ];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          "Vehicle Details",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            //product images
            SizedBox(
              height: Get.height / 60,
            ),
            CarouselSlider(
              items: listName
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
                            Text("  Vehicle Brand :  " +
                                widget.carsModel.carBrand),
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
                            Text("  Vehicle Location :  " +
                                widget.carsModel.carLocation),
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
                            Text(carSpecs),
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
                            Text("  Vehicle Mode :  " +
                                widget.carsModel.carMode.toString()),
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
                            Text(carSpecs),
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
                            Text("  Vehicle Millage :  " +
                                widget.carsModel.carDistance.toString()),
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
                            Text("  Vehicle Desciption :  " +
                                widget.carsModel.carDesciption),
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
                                widget.carsModel.carSellerName),
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
                                widget.carsModel.carSellerPhone.toString()),
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
                              width: Get.width * 0.2,
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
                                                userId:
                                                    widget.carsModel.sellerId,
                                                sellerName: widget
                                                    .carsModel.carSellerName,
                                              )));
                                  //sellerName: widget
                                  //                                                   .carsModel.carSellerName
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
                    ),
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

class rating extends StatefulWidget {
  const rating({super.key, required this.id});
  final String id;

  @override
  State<rating> createState() => _ratingState();
}

class _ratingState extends State<rating> {
  TextEditingController controller = TextEditingController();
  double ra = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedRatingStars(
          initialRating: ra,
          minRating: 0.0,
          maxRating: 5.0,
          filledColor: Colors.amber,
          emptyColor: Colors.grey,
          filledIcon: Icons.star,
          halfFilledIcon: Icons.star_half,
          emptyIcon: Icons.star_border,
          onChanged: (double rating) {
            ra = rating;
            setState(() {});
          },
          displayRatingValue: true,
          interactiveTooltips: true,
          customFilledIcon: Icons.star,
          customHalfFilledIcon: Icons.star_half,
          customEmptyIcon: Icons.star_border,
          starSize: 20,
          animationDuration: const Duration(milliseconds: 300),
          animationCurve: Curves.easeInOut,
          readOnly: false,
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Write Your Review",
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {
              if (controller.text.isEmpty) {
                Get.snackbar("Error", "Please Enter Your Review");
              } else if (ra == 0) {
                Get.snackbar("Error", "Please Enter Your Rating");
              } else {
                FirebaseFirestore.instance.collection("review").add({
                  "review": controller.text,
                  "rating": ra,
                  "uid": FirebaseAuth.instance.currentUser!.uid,
                  "adid": widget.id
                }).then((value) {
                  Navigator.pop(context);
                  Get.snackbar("Thank You", "Your Review has been submitted");
                });
              }
            },
            child: Text("Submit"))
      ],
    );
  }
}
