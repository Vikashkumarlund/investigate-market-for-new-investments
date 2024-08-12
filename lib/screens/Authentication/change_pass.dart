// ignore_for_file: file_names, camel_case_types, use_build_context_synchronously, unused_local_variable, unused_element
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../splash_screen.dart';



//import '../EP Profile/Navbar.dart';
//import '../Setting Screen/settings.dart';
// import 'package:sampleproject/EP%20Profile/Navbar.dart';
// import 'package:sampleproject/Setting%20Screen/settings.dart';


class changepassword extends StatefulWidget {
  const changepassword({super.key});

  @override
  State<changepassword> createState() => _changepasswordState();
}

class _changepasswordState extends State<changepassword> {
  final formkey = GlobalKey<FormState>();
  bool obscureTextt = true;
  bool _passwordVisible = false;
  bool _passwordVisible2 = false;
  final passcontroller = TextEditingController();
  final confirmpasscontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget buildpassword() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Old Password',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(),
            ),
            height: 60,
            child: TextFormField(
              controller: passcontroller,
              obscureText: !_passwordVisible,
              validator: (value) {
                if (value == "") {
                  return 'Field Cannot be left Empty';
                } else if (value.toString().length < 6) {
                  return 'Enter Minimum 6 characters';
                } else {
                  return null;
                }
              },
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.orange,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  hintText: 'Old Password',
                  errorStyle: const TextStyle(height: 0.1),
                  hintStyle: const TextStyle(color: Colors.black38)),
            ),
          )
        ],
      );
    }

    Widget buildconfirmpassword() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'New Password',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(),
            ),
            height: 60,
            child: TextFormField(
              controller: confirmpasscontroller,
              obscureText: !_passwordVisible2,
              validator: (value) {
                if (value == "") {
                  return 'Field Cannot be left Empty';
                } else if (value.toString().length < 6) {
                  return 'Enter Minimum 6 characters';
                } else {
                  return null;
                }
              },
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.orange,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible2
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible2 = !_passwordVisible2;
                      });
                    },
                  ),
                  hintText: 'New Password',
                  errorStyle: const TextStyle(height: 0.1),
                  hintStyle: const TextStyle(color: Colors.black38)),
            ),
          )
        ],
      );
    }

    Widget registerbtn() {
      return SizedBox(
        height: 40,
        width: double.infinity,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(Colors.orange),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ))),
            child: const Text('Change Password'),
            onPressed: () {
              signup();
            }),
      );
    }

    @override
    void dispose() {
      passcontroller.dispose();
      confirmpasscontroller.dispose();
      super.dispose();
    }

    @override
    void initState() {
      _passwordVisible = false;
      _passwordVisible2 = false;
      super.initState();
    }

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black45, Colors.deepOrange],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),), ),
              title: Text("Change Password"),
              centerTitle: true,
              titleTextStyle: TextStyle(fontSize: 27, fontWeight: FontWeight.w600, color: Colors.white),
              elevation: 1,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: ()
                {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashScreen()));
                },)),
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: Form(
              key: formkey,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(247, 247, 247, 1),
                    ),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(
                            height: 15,
                          ),
                          buildpassword(),
                          const SizedBox(
                            height: 20,
                          ),
                          buildconfirmpassword(),
                          const SizedBox(
                            height: 20,
                          ),
                          registerbtn(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  String getCurrentUserEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String email = user.email!;
      return email;
    } else {
      return '';
    }
  }

  Future signup() async {
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;
    try {
      String email = getCurrentUserEmail();

      AuthCredential credential = EmailAuthProvider.credential(
          email: email, password: passcontroller.text);
      UserCredential userCredential = await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(credential);
      await FirebaseAuth.instance.currentUser!
          .updatePassword(confirmpasscontroller.text);
      final user = FirebaseAuth.instance.currentUser!;

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password Changed Succesfully!')));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  SplashScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {

    }
    // Navigator.pop(context);
  }
}
