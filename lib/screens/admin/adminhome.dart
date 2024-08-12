import 'package:flutter/material.dart';
import 'package:fyp5/main.dart';
import 'package:fyp5/screens/Authentication/LogIn.dart';
import 'package:fyp5/screens/admin/adminchat.dart';
import 'package:fyp5/screens/admin/adminrequest.dart';
import 'package:fyp5/screens/admin/adminusers.dart';

class adminhome extends StatefulWidget {
  const adminhome({super.key});

  @override
  State<adminhome> createState() => _adminhomeState();
}

class _adminhomeState extends State<adminhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xffF5591F),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: InkWell(
          onTap: () {
            prefs.remove('email');
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false);
          },
          child: const Icon(Icons.logout),
        ),
        title: const Text(
          "Admin",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Admin",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  Text(
                    "Form here you can manage all things",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const adminuser()));
                      },
                      child: btn("User", "assets/user.png",const adminuser())),
                ),
                Expanded(
                  child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const adminchat()));
                      },
                      child: btn("Chat", "assets/chat.png", const adminchat())),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const adminrequest()));
                      },
                      child: btn("Request", "assets/request.png", const adminrequest())),
                ),
                const Expanded(child: SizedBox.shrink())
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget btn(String text, String img, widget) {
    return InkWell(
      child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
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
        Image.asset(
          img,
          width: 80,
          height: 80,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        )
      ],
            ),
          ),
    );
  }
}
