import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import 'newscreens/chatting.dart';

class adminrequest extends StatefulWidget {
  const adminrequest({super.key});

  @override
  State<adminrequest> createState() => _adminrequestState();
}

class _adminrequestState extends State<adminrequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xffF5591F),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Manage Request",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: FirestoreListView(
        query: FirebaseFirestore.instance
            .collection("sellit")
            .where("status", isEqualTo: "inactive"),
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, snapshot) {
          final user = snapshot.data();
          String id = snapshot.id;

          return Container(
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
                    user['type'] == "car"?
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
                      ],
                    ):
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
                              "property Mode : ${user['propertyMode']}",
                              style: const TextStyle(),
                            ),
                          ],
                        )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          user["doc"],
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
                        const Text(
                          "Document",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Type : ${user['type']}",
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async {
                    await FirebaseFirestore.instance
                        .collection("sellit")
                        .doc(id)
                        .update({
                      "status": "active",
                    }).then((value) {
                      Navigator.pop(context);
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    child: const Center(
                        child: Text(
                      "Active",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    String uid = prefs.getString("uid")!;
                    FirebaseFirestore.instance.collection('sellitchat')
                    .where("did", isEqualTo: user["sellerId"]).get().then((value) async {
                      if (value.docs.isEmpty){
                        DocumentReference ref = await FirebaseFirestore.instance.collection("sellitchat")
                            .add({
                          'uid': uid,
                          'did': user["sellerId"],
                          'time': DateTime.now().toString(),
                          'c': [],
                          "adid": id
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return Chatting(
                            id: ref.id,
                          );
                        }));
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return Chatting(
                            id: value.docs.first.id,
                          );
                        }));
                      }
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                    ),
                    child: const Center(
                        child: Text(
                          "Chat",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ),
                )
              ],
            ),
          );
        },
      )),
    );
  }
}
