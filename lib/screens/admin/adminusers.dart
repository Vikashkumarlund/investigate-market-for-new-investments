import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

class adminuser extends StatefulWidget {
  const adminuser({super.key});

  @override
  State<adminuser> createState() => _adminuserState();
}

class _adminuserState extends State<adminuser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xffF5591F),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Manage Users",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: FirestoreListView(
          query: FirebaseFirestore.instance.collection("users"),
          padding: const EdgeInsets.all(8.0),
          itemBuilder: (context, snapshot) {
            final user = snapshot.data();
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
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user['username'],
                            style: const TextStyle(
                                color: Color(0xffF5591F),
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            user['email'],
                            style: const TextStyle(color: Colors.black),
                          ),
                          Text(
                            user['phone'],
                            style: const TextStyle(color: Colors.black),
                          ),
                          Text(
                            user['status'],
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      user['status'] == "inactive"
                          ? btn("active", Colors.green, user['uId'])
                          : btn("inactive", Colors.red, user['uId']),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget btn(String text, Color col, String id) {
    return Expanded(
      child: InkWell(
        onTap: () async {
          await FirebaseFirestore.instance.collection("users").doc(id).update({
            "status": text,
          });
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: col,
          ),
          child: Center(
              child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}
