import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:fyp5/screens/Property/update_property_record.dart';
import 'package:get/get.dart';

import '../../models/property_model.dart';
import '../../widgets/icon_and_text_widget.dart';

class UpdateDeleteProperty extends StatefulWidget {
  const UpdateDeleteProperty({super.key});
  @override
  State<StatefulWidget> createState() => _UpdateDeletePropertyState();
}

/*
Future deleteData(String id) async{
try {
  await  FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("collection_name")
      .doc(id)
      .delete();
}catch (e){
  return false;
}

try
{
  await firebase_storage.FirebaseStorage.instance.ref('/images/something.jpg').delete();
 } catch (e) {
  debugPrint('Error deleting $yourReference: $e');
}
 */
Future deleteStorageImage(String url) async {
  try {
    await firebase_storage.FirebaseStorage.instance.ref(url).delete();
    return true;
  } catch (e) {
    debugPrint('Error deleting $url: $e');
    return false;
  }
}

Future deleteData(String id) async {
  try {
    await FirebaseFirestore.instance.collection("property").doc(id).delete();
    return true;
  } catch (e) {
    return false;
  }
}

class _UpdateDeletePropertyState extends State<UpdateDeleteProperty> {
  User? user = FirebaseAuth.instance.currentUser;
  late CollectionReference _collectionRef;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _collectionRef = FirebaseFirestore.instance.collection('property');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Update & Delete Property"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: _collectionRef
                      .where('sellerId', isEqualTo: user?.uid.toString())
                      .snapshots(),
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
                        width: MediaQuery.of(context).size.width,
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
                                /*  onTap: () =>
                                    Get.to(() => SingleVehicleDetailsScreen(
                                          carsModel: carsModel,
                                        )),*/
                                child: Container(
                              margin: EdgeInsets.only(
                                  left: 2, right: 2, bottom: 10),
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
                                            EdgeInsets.only(left: 1, right: 1),
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
                                                IconButton(
                                                  iconSize: 25,
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    color: Colors.orange,
                                                  ),
                                                  // the method which is called
                                                  // when button is pressed
                                                  onPressed: () {
                                                    Get.to(() =>
                                                        UpdatePropertyRecord(
                                                            propertyModel:
                                                                propertyModel,
                                                            id: document.id));
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 1,
                                                ),
                                                IconButton(
                                                  iconSize: 20,
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.orange,
                                                  ),
                                                  // the method which is called
                                                  // when button is pressed
                                                  onPressed: () {
                                                    setState(
                                                      () {
                                                        deleteStorageImage(
                                                            propertyModel.imgUrl
                                                                .toString());
                                                        deleteData(document.id
                                                            .toString());
                                                      },
                                                    );
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              propertyModel.propertyTitle,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
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
                                                    text: propertyModel
                                                        .propertyCity,
                                                    iconColor: Colors.orange),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                IconAndTextWidget(
                                                    icon: Icons
                                                        .access_time_rounded,
                                                    text: propertyModel
                                                        .propertyArea
                                                        .toString(),
                                                    iconColor: Colors.orange),
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
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Show Dialog"),
                ),
              ],
            ),
          ),
        ));
  }
}
