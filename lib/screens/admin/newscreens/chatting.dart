import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../main.dart';
import '../../../utils/app-constant.dart';

class Chatting extends StatefulWidget {
  const Chatting({super.key, required this.id});
  final String id;

  @override
  State<Chatting> createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppConstant.appMainColor,
        title: const Text(
          "Chatting",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('sellitchat')
                .doc(widget.id)
                .get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List data = snapshot.data.data()['c'] as List;
                data = data.reversed.toList();
                return ListView.builder(
                  itemCount: data.length,
                  reverse: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Align(
                      alignment: data[index]['sender'] == prefs.getString("uid")
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: data[index]['sender'] == prefs.getString("uid")
                              ? Colors.green.shade100
                              : Colors.amber.shade100,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[index]['mes'],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            Text(
                              data[index]['date']
                                  .toDate()
                                  .toString()
                                  .substring(0, 10),
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
          )),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Enter Message",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    Map<String, dynamic> newItem = {
                      "mes": messageController.text,
                      "sender": prefs.getString("uid"),
                      "date": Timestamp.now(),
                    };

                    await FirebaseFirestore.instance
                        .collection('sellitchat')
                        .doc(widget.id)
                        .get()
                        .then((value) {
                      List c = List.of(value.data()!['c']);
                      c.add(newItem);
                      FirebaseFirestore.instance
                          .collection('sellitchat')
                          .doc(widget.id)
                          .update({'c': c});
                    });
                    setState(() {});
                    messageController.clear();
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
