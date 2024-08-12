import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp5/screens/Vehicles/single_vehicle_detail.dart';
import 'package:get/get.dart';

import '../../Repository/SearchItems.dart';
import '../../models/cars_model.dart';
import '../../widgets/icon_and_text_widget.dart';

var selectedModel;

class SearchCarPage extends StatefulWidget {
  const SearchCarPage({super.key});

  @override
  _SearchCarPageState createState() => _SearchCarPageState();
}

class _SearchCarPageState extends State<SearchCarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CarSearch());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}

class CarSearch extends SearchDelegate<Cars> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.navigate_before),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    /*final List<String> searchResults = searchList
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();*/
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('cars')
          .where('carModel', isEqualTo: selectedModel)
          //   .where('carLocation', isEqualTo: carBrand1.toString())
          //   .where('carPrice', isGreaterThan: 2000000)
          .snapshots(),
      //FirebaseFirestore.instance.collection('categories').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 50,
            child: const Center(
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
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: documents.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot document = documents[index];
                String id = documents[index].id;
                CarsModel carsModel = CarsModel(
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
                    onTap: () => Get.to(() => SingleVehicleDetailsScreen(
                          carsModel: carsModel,
                          id: id,
                        )),
                    child: Container(
                      margin: const EdgeInsets.only(left: 2, right: 2, bottom: 10),
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
                                    carsModel.imgUrl,
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
                                padding: const EdgeInsets.only(left: 1, right: 1),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(carsModel.carBrand),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(carsModel.carPrice
                                        .toString()
                                        .toString()),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconAndTextWidget(
                                            icon: Icons.location_on,
                                            text: carsModel.carLocation,
                                            iconColor: Colors.greenAccent),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        IconAndTextWidget(
                                            icon: Icons.access_time_rounded,
                                            text: carsModel.carDistance
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
    );
    /*ListView.builder(
      itemCount: 9,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(selectedModel.toString()),
          onTap: () {
            // Handle the selected search result.
            //close(context, searchResults[index]);
          },
        );
      },
    );*/
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final listItems = query.isEmpty
        ? studentDetails
        : studentDetails
            .where((element) => element.model
                .toLowerCase()
                .startsWith(query.toLowerCase().toString()))
            .toList();

    return listItems.isEmpty
        ? const Center(child: Text("No Data Found!"))
        : ListView.builder(
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(left: 15.00, right: 15.00),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.person,
                          size: 40,
                        ),
                        title: Text(listItems[index].brand),
                        subtitle: Text("Model : ${(listItems[index].model)}"),
                        onTap: () {
                          showResults(context);
                          selectedModel = listItems[index].model;
                        },
                      ),
                      const Divider(),
                    ],
                  ));
            });
  }
}
