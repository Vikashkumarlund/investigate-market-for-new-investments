import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp5/models/user-model.dart';

import '../screens/chat/chat_screen.dart';

//card to represent a single user in home screen
class ChatUserCard extends StatefulWidget {
  final UserModel user;
  const ChatUserCard({super.key, required this.user});
  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      //margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      // color: Colors.blue.shade100,
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          //for navigating to chat screen
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ChatScreen(
                        userId: widget.user.uId,
                        sellerName: widget.user.username,
                      )));
        },
        child: ListTile(
          //user profile picture
          leading: CircleAvatar(
            child: Icon(CupertinoIcons.person),
          ),

          //user name
          title: Text(widget.user.username),

          //last message
          subtitle: Text(widget.user.email, maxLines: 1),

          //last message time
          trailing:
              //message sent time
              Text(
            "time",
            style: const TextStyle(color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
