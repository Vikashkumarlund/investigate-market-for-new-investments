import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fyp5/controllers/sign_up_controller.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../utils/app-constant.dart';
import 'LogIn.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<StatefulWidget> createState() => Signup();
}

class Signup extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  //SignUpController signUpController = Get.find();
  SignUpController signUpController = Get.find<SignUpController>();

  //CollectionReference ref = FirebaseFirestore.instance.collection('Users');

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phonecontroller = TextEditingController();
  final confirmpassword = TextEditingController();
  int maxlength = 11;

  /*var options = [
    'Investor',
    'Entrepreneur',
    'Admin',
  ];
  var _currentItemSelected = "Investor";
  var rool = "Investor";*/

  bool showPass = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    signUpController.isLoading.value = false;
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    phonecontroller.dispose();
    confirmpassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
          child: Scaffold(
              body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(90)),
                        gradient: LinearGradient(
                            colors: [(Color(0xffF5591F)), (Color(0xffF2861E))],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 50),
                            height: 90,
                            width: 90,
                            child: Image.asset("assets/investor.png"),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 20, top: 20),
                            alignment: Alignment.bottomRight,
                            child: const Text(
                              "Register",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200],
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE))
                      ],
                    ),
                    alignment: Alignment.center,
                    child: TextFormField(
                      inputFormatters: [
                        // only accept letters from a to z
                        FilteringTextInputFormatter(RegExp(r'[a-zA-Z]'),
                            allow: true)
                      ],
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name Cannot be Empty';
                        }
                        return null;
                      },
                      cursorColor: const Color(0xffF5591F),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Color(0xffF5591F),
                        ),
                        hintText: "Full Name",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200],
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE))
                      ],
                    ),
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: emailController,
                      validator: (val) {
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val!);
                        if (val == "") {
                          return 'Email Cannot be Empty';
                        } else if (!emailValid) {
                          return 'Invalid Email Address';
                        } else {
                          return null;
                        }
                      },
                      cursorColor: const Color(0xffF5591F),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Color(0xffF5591F),
                        ),
                        hintText: "Enter Email",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200],
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE))
                      ],
                    ),
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: phonecontroller,
                      maxLength: maxlength,
                      cursorColor: const Color(0xffF5591F),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.phone,
                          color: Color(0xffF5591F),
                        ),
                        hintText: "Phone Number",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Required"),
                        MaxLengthValidator(11, errorText: "11 required"),
                        PatternValidator(r'^(?:[+0][1-9])?[0-9]{10,12}$',
                            errorText: 'error'),

                        //(errorText: " Not valid")
                      ]),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200],
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE))
                      ],
                    ),
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == "") {
                          return 'Field Cannot be left Empty';
                        } else if (value.toString().length < 6) {
                          return 'Enter Minimum 6 characters';
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      cursorColor: const Color(0xffF5591F),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.vpn_key,
                          color: Color(0xffF5591F),
                        ),
                        hintText: "Enter Password",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200],
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE))
                      ],
                    ),
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: confirmpassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == "") {
                          return 'Field Cannot be left Empty';
                        } else if (value.toString().length < 6) {
                          return 'Enter Minimum 6 characters';
                        } else if (value != passwordController.text) {
                          return 'Password Doesnot Match';
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      cursorColor: const Color(0xffF5591F),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.visibility_off,
                          color: Color(0xffF5591F),
                        ),
                        hintText: "Confirm Password",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10.0,
                  ),

                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Sign In as: ",
                        style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      DropdownButton<String>(
                        dropdownColor: Colors.white70,
                        isDense: true,
                        isExpanded: false,
                        iconEnabledColor: Colors.white,
                        focusColor: Colors.white,
                        items: options.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(
                              dropDownStringItem,
                              style: const TextStyle(
                                color: Colors.black87,
                                // fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValueSelected) {
                          setState(() {
                            _currentItemSelected = newValueSelected!;
                            rool = newValueSelected;
                          });
                        },
                        value: _currentItemSelected,
                        icon: const Icon(
                          Icons.arrow_drop_down_circle,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),*/

                  // SizedBox(height: 20.0,),
                  // Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: <Widget>[
                  //
                  //       SizedBox(width: 50.0,),
                  //       DropdownButton(
                  //         // value: _selectedVal,
                  //           items: _User.map(
                  //               (e) => DropdownMenuItem(child: Text(e), value: e,)
                  //           ).toList(),
                  //           onChanged:(val){
                  //           setState(() {
                  //             _selectedVal = val as String;
                  //           });
                  //           },
                  //         icon: const Icon(
                  //           Icons.arrow_drop_down_circle,
                  //           color: Colors.deepOrange,
                  //         ),
                  //       ),
                  //
                  //     ],
                  // ),

                  /*GestureDetector(
                    onTap: () => {
                      signup(),
                      setState(() {
                        "Register";
                      })
                    },
                       child: Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 30),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        alignment: Alignment.center,
                        height: 54,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [
                                (const Color(0xffF5591F)),
                                (const Color(0xffF5591F))
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 50,
                                color: Color(0xffEEEEEE))
                          ],
                        ),
                        child: const Text(
                        "REGISTER",
                        style: TextStyle(color: Colors.white),
                      ),*/
                  Obx(
                    () => ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (const Color(0xffF5591F)),
                        fixedSize: const Size(300, 44),
                      ),
                      onPressed: signUpController.isLoading.value
                          ? null
                          : () => signup(),
                      icon: signUpController.isLoading.value
                          ? const CircularProgressIndicator()
                          : const Icon(Icons.upload),
                      label: Text(
                        signUpController.isLoading.value
                            ? 'Processing'
                            : 'Upload',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  //   ),),

                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already Member? "),
                        GestureDetector(
                          onTap: () => Get.to(const LoginScreen()),
                          child: const Text(
                            "Login Now",
                            style: TextStyle(color: Color(0xffF5591F)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
        ));
  }

  Future authprofilesetting(
      UserCredential cred, String name, String contact) async {
    await cred.user?.updateDisplayName(name);
    await cred.user?.updatePhoneNumber(contact as PhoneAuthCredential);
    // await cred.user?.updatePhotoURL(
    //     'https://firebasestorage.googleapis.com/v0/b/pc-builder-2c0a4.appspot.com/o/DisplayPicture%2Fdefaultimage.jpg?alt=media&token=af41bdaf-f5f4-4f0d-ad96-78734f8eb73a');
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => context.pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => {
                  SystemChannels.platform
                      .invokeMethod<void>('SystemNavigator.pop'),
                },
                //SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future signup() async {
    String name = nameController.text;
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    UserCredential? userCredential = await signUpController.signup(
      emailController.text.toString(),
      passwordController.text.toString(),
      nameController.text.toString(),
      phonecontroller.text.toString(),
      "Address",
    );
    if (userCredential != null) {
      Get.snackbar(
        "Verification email sent.",
        "Please check your email.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appScendoryColor,
        colorText: AppConstant.appTextColor,
      );

      FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    }
    /*try {
     showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );*/

    /*UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text);
      authprofilesetting(result, nameController.text, phonecontroller.text);
      final user = FirebaseAuth.instance.currentUser!;
      final docuser =
      FirebaseFirestore.instance.collection('Users').doc(user.uid);

      final data = {
        'Name': nameController.text,
        'role': rool.toString(),
        'Email': emailController.text,
        'Address': '',
        'Phone': int.parse(phonecontroller.text)
      };
      await docuser.set(data);
      Fluttertoast.showToast(msg: 'Signup Succesful!');*/

    /*Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
     // context.go("/Login");
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.BOTTOM);
    }*/
    //Navigator.pop(context);
  }
}
