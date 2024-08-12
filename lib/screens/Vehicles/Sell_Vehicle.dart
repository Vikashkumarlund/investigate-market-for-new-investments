import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/Car_controller.dart';
import '../../utils/app-constant.dart';

class SellVehicleScreen extends StatefulWidget {
  const SellVehicleScreen({super.key});
  @override
  State<StatefulWidget> createState() => SellVehicle();
}

class SellVehicle extends State<SellVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  CarController carController = Get.find();
  CollectionReference ref = FirebaseFirestore.instance.collection('Users');

  bool containerPriceVisible = true;
  bool containerRentVisible = false;

  void toggleContainerVisibility() {
    if (_currentItemSelectedMode == "Sell") {
      setState(() {
        containerPriceVisible = true;
        containerRentVisible = false;
        modeController.text = '0';
      });
    } else {
      setState(() {
        containerPriceVisible = false;
        containerRentVisible = true;
        priceController.text = '0';
      });
    }
  }

  final distanceController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final modeController = TextEditingController();
  final sellerNameController = TextEditingController();
  final sellerPhoneController = TextEditingController();
  int maxlength = 11;

  var options_location = [
    'Lahore',
    'Peshawar',
    'Islamabad',
    'Karachi',
    'Sahiwal',
    'Sialkot',
  ];
  var options_brand = ['BMW', 'Mazda', 'KIA', 'Infiniti', 'Lexus', 'Mercedes'];
  var options_mode = ['Sell', 'Rent'];
  var _currentItemSelectedLocation = "Lahore";
  var _currentItemSelectedBrand = "BMW";
  var _currentItemSelectedMode = "Sell";

  bool showPass = true;
  bool isLoading = false;

  String a = "sell";

  @override
  void initState() {
    super.initState();
    carController.isLoading.value = false;
    modeController.text = '0';
    priceController.text = '0';
  }

  @override
  void dispose() {
    super.dispose();
    distanceController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    sellerNameController.dispose();
    sellerPhoneController.dispose();
  }

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  String sellerImageUrl = "";

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  XFile? image;
  Future<void> _getImage2() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image =imageXFile;
    });
  }

  Widget sellit(String title) {
    return InkWell(
      onTap: () {
        a = title;
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: title == a
              ? const Color(0xffF5591F)
              : Colors.grey.withOpacity(0.2),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: title == a ? Colors.white : Colors.black,
                fontSize: 15),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Get.back();
          return false;
        },
        child: SafeArea(
          child: Scaffold(
              body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  //Vehicle Image
                  Container(
                    height: 220,
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
                          const SizedBox(
                            height: 5.0,
                          ),
                          InkWell(
                              onTap: () {
                                _getImage();
                              },
                              child: CircleAvatar(
                                radius: MediaQuery.of(context).size.width / 5,
                                backgroundColor: Colors.white,
                                backgroundImage: imageXFile == null
                                    ? null
                                    : FileImage(File(imageXFile!.path)),
                                child: imageXFile == null
                                    ? Icon(
                                        Icons.add_photo_alternate,
                                        size:
                                            MediaQuery.of(context).size.width /
                                                6,
                                        color: Colors.grey,
                                      )
                                    : null,
                              )),
                          /*   Container(
                            margin: const EdgeInsets.only(right: 20, top: 20),
                            alignment: Alignment.bottomRight,
                            child: const Text(
                              "Upload Image",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          )*/
                        ],
                      ),
                    ),
                  ),
                  // sell sellit
                  Row(
                    children: [
                      sellit("sell"),
                      sellit("sellit"),
                    ],
                  ),
                  //Location
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_city,
                            color: Color(0xffF5591F),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Location: ",
                            style: TextStyle(
                              fontSize: 20,
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
                            items: options_location
                                .map((String dropDownStringItem) {
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
                                _currentItemSelectedLocation =
                                    newValueSelected!;
                              });
                            },
                            value: _currentItemSelectedLocation,
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ]),
                  ),
                  //Brand
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.branding_watermark,
                            color: Color(0xffF5591F),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Brand: ",
                            style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 10),
                          DropdownButton<String>(
                            dropdownColor: Colors.white70,
                            isDense: true,
                            isExpanded: false,
                            iconEnabledColor: Colors.white,
                            focusColor: Colors.white,
                            items:
                                options_brand.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(
                                  dropDownStringItem,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValueSelected) {
                              setState(() {
                                _currentItemSelectedBrand = newValueSelected!;
                              });
                            },
                            value: _currentItemSelectedBrand,
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ]),
                  ),
                  //mode
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.branding_watermark,
                            color: Color(0xffF5591F),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Mode: ",
                            style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 10),
                          DropdownButton<String>(
                            dropdownColor: Colors.white70,
                            isDense: true,
                            isExpanded: false,
                            iconEnabledColor: Colors.white,
                            focusColor: Colors.white,
                            items:
                                options_mode.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(
                                  dropDownStringItem,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValueSelected) {
                              setState(() {
                                _currentItemSelectedMode = newValueSelected!;
                                toggleContainerVisibility();
                              });
                            },
                            value: _currentItemSelectedMode,
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ]),
                  ),
                  //Rent/Installment
                  Visibility(
                      visible: containerRentVisible,
                      child: Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 30),
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
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered
                          controller: modeController,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Required"),
                          ]),
                          cursorColor: const Color(0xffF5591F),
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.price_change,
                              color: Color(0xffF5591F),
                            ),
                            hintText: "Montly Rent",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      )),
                  //Kms Driven
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
                      controller: distanceController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ], // Only numbers can be entered
                      validator: MultiValidator(
                          [RequiredValidator(errorText: "Required")]),
                      cursorColor: const Color(0xffF5591F),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.social_distance,
                          color: Color(0xffF5591F),
                        ),
                        hintText: "KMs Driven",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  //Price
                  Visibility(
                      visible: containerPriceVisible,
                      child: Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 30),
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
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered
                          controller: priceController,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Required"),
                          ]),
                          cursorColor: const Color(0xffF5591F),
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.price_change,
                              color: Color(0xffF5591F),
                            ),
                            hintText: "Price",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      )),
                  //Description
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
                        FilteringTextInputFormatter(RegExp(r'[a-zA-Z]+|\s'),
                            allow: true)
                      ],
                      controller: descriptionController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Description Cannot be Empty';
                        }
                        return null;
                      },
                      cursorColor: const Color(0xffF5591F),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Color(0xffF5591F),
                        ),
                        hintText: "Product Description",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  a == 'sell'?
                      Column(
                        children: [
                          //Contact Information Header
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Contact Information: ",
                                style: TextStyle(
                                  fontSize: 15,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          //Seller name
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
                                FilteringTextInputFormatter(RegExp(r'[a-zA-Z]+|\s'),
                                    allow: true)
                              ],
                              controller: sellerNameController,
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
                                hintText: "Seller Name",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          //Seller phone number
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
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ], // Only numbers can be entered
                              controller: sellerPhoneController,
                              maxLength: maxlength,
                              cursorColor: const Color(0xffF5591F),
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.phone,
                                  color: Color(0xffF5591F),
                                ),
                                hintText: "Seller Phone Number",
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
                        ],
                      ): image == null?
                          InkWell(
                            onTap: ()=>_getImage2(),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1, color: AppConstant.appMainColor),
                              ),
                              child: const Text("Upload Document", style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ):InkWell(
                      onTap: ()=>_getImage2(),
                      child: Image.file(File(image!.path), height: 200, width: 200, fit: BoxFit.fill,)),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (const Color(0xffF5591F)),
                        fixedSize: const Size(350, 44),
                      ),
                      onPressed: carController.isLoading.value
                          ? null
                          : () => CarRegister(),
                      icon: carController.isLoading.value
                          ? const CircularProgressIndicator()
                          : const Icon(
                              Icons.upload,
                              color: Colors.white,
                            ),
                      label: Text(
                        carController.isLoading.value
                            ? 'Processing'
                            : 'Post Your Ad',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ));
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

  Future CarRegister() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid || imageXFile == null) {
      Get.snackbar(
        "Select Image",
        "of your product",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appScendoryColor,
        colorText: AppConstant.appTextColor,
      );
      return;
    } else {
      //EasyLoading.show(status: "Please wait");
      /* setState(() {
        _showCircle = !_showCircle;
      });*/
      carController.isLoading.value = true;
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = fStorage.FirebaseStorage.instance
          .ref()
          .child("Vehicles")
          .child(fileName);
      fStorage.UploadTask uploadTask =
          reference.putFile(File(imageXFile!.path));
      fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      await taskSnapshot.ref.getDownloadURL().then((url) {
        sellerImageUrl = url;
      });
      //EasyLoading.dismiss();
      carController.isLoading.value = false;
    }

    // Call to Car register controleer

    final user = FirebaseAuth.instance.currentUser!;
    late bool b ;
    if (a == "sell") {
      b = await carController.addCar(
          user.uid,
          sellerImageUrl.toString(),
          _currentItemSelectedLocation.toString(),
          _currentItemSelectedBrand.toString(),
          descriptionController.text,
          sellerNameController.text,
          int.parse(sellerPhoneController.text),
          int.parse(distanceController.text),
          int.parse(priceController.text),
          _currentItemSelectedMode.toString(),
          int.parse(modeController.text));
    } else {

      String doc = "";
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = fStorage.FirebaseStorage.instance
          .ref()
          .child("Vehicles")
          .child(fileName);
      fStorage.UploadTask uploadTask =
      reference.putFile(File(image!.path));
      fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      await taskSnapshot.ref.getDownloadURL().then((url) {
        doc = url;
      });

      await FirebaseFirestore.instance.collection('sellit').add({
        'sellerId': user.uid,
        'imgUrl': sellerImageUrl.toString(),
        'carLocation': _currentItemSelectedLocation.toString(),
        'carBrand': _currentItemSelectedBrand.toString(),
        'carDesciption': descriptionController.text,
        'carDistance': int.parse(distanceController.text),
        'carPrice': int.parse(priceController.text),
        'carMode': _currentItemSelectedMode.toString(),
        'carInstallment': int.parse(modeController.text),
        "status": "inactive",
        "doc": doc,
        "type": "car",
      }).then((value) {
        carController.isLoading.value = false;
        b = true;
      });
    }
    distanceController.clear();
    priceController.clear();
    descriptionController.clear();
    sellerNameController.clear();
    sellerPhoneController.clear();
    image = null;
    imageXFile = null;
    if (b == true) {
      Get.snackbar(
        "Your Product is successfully",
        "added in the Database",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appScendoryColor,
        colorText: AppConstant.appTextColor,
      );
    }
  }
}
