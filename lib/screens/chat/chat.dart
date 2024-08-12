//home screen -- where all available contacts are shown
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../controllers/apis.dart';
import '../../main.dart';
import '../../models/user-model.dart';
import '../../widgets/chat_user_card.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  // for storing all users
  List<UserModel> _list = [];

  @override
  void initState() {
    super.initState();
    //APIs.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.home),
        title: const Text('Chat Home Page'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      /*floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            await GoogleSignIn().signOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const LoginScreen()));
          },
          child: const Icon(Icons.logout),
        ),
      ),*/
      body: StreamBuilder(
        stream: APIs.getAllUsers1(),

        //get only those user, who's ids are provided
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            //if data is loading
            case ConnectionState.waiting:
            case ConnectionState.none:
            // return const Center(
            //     child: CircularProgressIndicator());

            //if some or all data is loaded then show it
            case ConnectionState.active:
            case ConnectionState.done:
              //  final data = snapshot.data?.docs;
              //  _list = data?.map((e) => ChatUser.fromJson(data)).toList() ?? [];

              if (snapshot.hasData) {
                List<DocumentSnapshot> documents = snapshot.data!.docs;

                if (documents.isNotEmpty) {
                  return ListView.builder(
                      itemCount: documents.length,
                      padding: EdgeInsets.only(top: mq.height * .01),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = documents[index];
                        UserModel chatuser = UserModel(
                          uId: document['uId'],
                          username: document['username'],
                          email: document['email'],
                          phone: document['phone'],
                          userAddress: document['userAddress'],
                          isAdmin: document['isAdmin'],
                          userpassword: document['userpassword'],
                          status: document['status'],
                        );
                        return ChatUserCard(user: chatuser);
                      });
                }
                return Container();
              } else {
                return Container();
                /* return const Center(
                  child: Text('No Connections Found!',
                      style: TextStyle(fontSize: 20)),
                );*/
              }
          }
        },
      ),
      // To show users
      /*body: StreamBuilder(
        stream: APIs.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          final list = [];
          if (snapshot.hasData) {
            final data = snapshot.data?.docs;
            for (var i in data!) {
              list.add(i.data()['name']);
            }
          }
          return ListView.builder(
              itemCount: list.length,
              padding: EdgeInsets.only(top: mq.height * .01),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Text('Name: ${list[index]}');
              });
        },
      ),*/
    );
  }
}
