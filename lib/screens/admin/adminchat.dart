import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp5/main.dart';

import 'newscreens/chatting.dart';

class adminchat extends StatefulWidget {
  const adminchat({super.key, this.isadmin = false});
  final bool isadmin;

  @override
  State<adminchat> createState() => _adminchatState();
}

class _adminchatState extends State<adminchat> {
  var query;
  @override
  void initState() {
    if (widget.isadmin) {
      query = FirebaseFirestore.instance
          .collection("sellitchat")
          .where("uid", isEqualTo: "admin");
    } else {
      FirebaseFirestore.instance
          .collection("sellitchat")
          .where("did", isEqualTo: prefs.getString("uid"));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xffF5591F),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.isadmin ? "User Chats" : "Admin Chats",
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: FirestoreListView(
        query: FirebaseFirestore.instance
            .collection("sellitchat")
            .where("uid", isEqualTo: "admin"),
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, snapshot) {
          final user = snapshot.data();
          String id = snapshot.id;
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Chatting(
                  id: id,
                );
              }));
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
                        .collection('sellit')
                        .doc(user["adid"])
                        .get(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        Map data = snapshot.data.data() as Map;
                        return Row(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  data['imgUrl'],
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text(
                                  data["carBrand"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  data["carDesciption"],
                                  style: const TextStyle(),
                                ),
                              ],
                            )
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Icon(
                            Icons.error,
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.person),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .where("uId", isEqualTo: user["did"])
                                .get(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                var user = snapshot.data!.docs[0].data();
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name : ${user['username']}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Phone : ${user['phone']}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
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
                          Text(
                            user['time'].toString().substring(0, 16),
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
      )),
    );
  }
}
