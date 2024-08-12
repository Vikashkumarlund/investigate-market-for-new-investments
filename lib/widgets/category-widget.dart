// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../models/categories-model.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('categories').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error"),
          );
        }
        /* if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: Get.height / 5,
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text("No category found!"),
          );
        }*/

        if (snapshot.hasData) {
          List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              DocumentSnapshot document = documents[index];
              CategoriesModel categoriesModel = CategoriesModel(
                categoryId: document['categoryId'],
                categoryImg: document['categoryImg'],
                categoryName: document['categoryName'],
                createdAt: document['createdAt'],
                updatedAt: document['updatedAt'],
              );
              return Row(
                children: [
                  Container(
                    height: 50,
                    color: Colors.red,
                    child: FillImageCard(
                      borderRadius: 20.0,
                      width: Get.width / 4.0,
                      heightImage: Get.height / 12,
                      imageProvider: CachedNetworkImageProvider(
                        categoriesModel.categoryImg,
                      ),
                      title: Center(
                        child: Text(
                          categoriesModel.categoryName,
                          style: TextStyle(
                              fontSize: 12.0, color: Colors.deepPurpleAccent),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }

        return Container();
      },
    );
  }
}
