import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyHomePage1 extends StatefulWidget {
  final String title;

  const MyHomePage1({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<MyHomePage1> createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {
  FirebaseAuth auth = FirebaseAuth.instance;

  signOut() async {
    await auth.signOut();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want Signout'),
            actions: <Widget>[
              TextButton(
                onPressed: () => context.pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => {
                  signOut(),
                  context.go("/Login"),
                },
                //SystemNavigator.pop(),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            /* leading: new IconButton(
          icon: new Icon(Icons.ac_unit),
          onPressed: () => {
            signOut(),
          context.go("/Login"),
          },
        ),*/
          ),
          body: Center(
              child: ElevatedButton(
                  onPressed: () {
                    // _showAlertDialog();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: const Text(
                    "Open Dialog",
                    style: TextStyle(color: Colors.white),
                  ))),
        ));
  }

  void _showAlertDialog() {
    // set up the buttons
    Widget Answer1Button = TextButton(
      child: Text("Cars"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget Answer2Button = TextButton(
      child: Text("Property"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text(),
      content: Text("Alert Dialog"),
      actions: [
        Answer1Button,
        Answer2Button,
      ],
    );
  }
}
