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

import '../../controllers/Property_controller.dart';
import '../../utils/app-constant.dart';

class SellPropertyScreen extends StatefulWidget {
  const SellPropertyScreen({super.key});
  @override
  State<StatefulWidget> createState() => SellProperty();
}

class SellProperty extends State<SellPropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  PropertyController propertyController = Get.find();
  bool _showCircle = false;
  CollectionReference ref = FirebaseFirestore.instance.collection('Users');

  bool containerPriceVisible = true;
  bool containerRentVisible = false;

  void toggleContainerVisibility() {
    if (_currentItemSelectedMode == "Sell") {
      setState(() {
        containerPriceVisible = true;
        containerRentVisible = false;
        monthlyInstallmentController.text = '0';
      });
    } else {
      setState(() {
        containerPriceVisible = false;
        containerRentVisible = true;
        priceController.text = '0';
      });
    }
  }

  final monthlyInstallmentController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final titleController = TextEditingController();
  final sellerNameController = TextEditingController();
  final sellerPhoneController = TextEditingController();
  int maxlength = 11;

  String firstBtn = "House";
  String secondBtn = "Flat";
  String thirdBtn = "Farm House";
  String selectedType = "House";

  var options_location = [
    'Lahore',
    'Peshawar',
    'Islamabad',
    'Karachi',
    'Sahiwal',
    'Sialkot',
  ];
  var options_brand = [
    '5 Marla',
    '8 Marla',
    '10 Marla',
    '12 Marla',
  ];
  var options_mode = ['Sell', 'Rent'];
  var _currentItemSelectedLocation = "Lahore";
  var rool = "Investor";
  var _currentItemSelectedMode = "Sell";
  var _currentItemSelectedArea = "5 Marla";

  bool showPass = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    monthlyInstallmentController.text = '0';
    priceController.text = '0';
  }

  @override
  void dispose() {
    super.dispose();
    monthlyInstallmentController.dispose();
    titleController.dispose();
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

  String a = "sell";

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
    double screenWidth = MediaQuery.of(context).size.width;
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
                  //Property Image
                  Container(
                    height: 220,
                    width: screenWidth,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(90)),
                        gradient: LinearGradient(
                            colors: [
                              (new Color(0xffF5591F)),
                              (new Color(0xffF2861E))
                            ],
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
                  Row(
                    children: [
                      sellit("sell"),
                      sellit("sellit"),
                    ],
                  ),
                  //Select the type of property
                  Container(
                    margin: const EdgeInsets.only(left: 8, right: 2, top: 30),
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    alignment: Alignment.center,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[200]),
                            icon: const Icon(
                              Icons.home,
                              color: Colors.orange,
                              size: 20,
                            ),
                            label: const Text(
                              "Home",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              setState(() {
                                firstBtn = "Home";
                                secondBtn = "Flat";
                                thirdBtn = "Farm";
                              });
                            },
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          ElevatedButton.icon(
                            icon: const Icon(
                              Icons.build_sharp,
                              color: Colors.orange,
                              size: 20,
                            ),
                            label: const Text(
                              "Plot",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              setState(() {
                                firstBtn = "Residential";
                                secondBtn = "Commercial";
                                thirdBtn = "Agricultural";
                              });
                            },
                          ),
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8, right: 2),
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    alignment: Alignment.center,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(
                              Icons.tour_rounded,
                              color: Colors.orange,
                              size: 20,
                            ),
                            label: const Text(
                              "Commercial",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              setState(() {
                                firstBtn = "Office";
                                secondBtn = "Shop";
                                thirdBtn = "Factory";
                              });
                            },
                          ),
                        ]),
                  ),
                  //Sub Types of property
                  const Divider(color: Colors.orange),
                  Container(
                    margin: const EdgeInsets.only(left: 8, right: 2),
                    padding: const EdgeInsets.only(top: 3, bottom: 3),
                    alignment: Alignment.center,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(
                              Icons.home,
                              color: Colors.orange,
                              size: 20,
                            ),
                            label: Text(
                              firstBtn,
                              style: const TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              selectedType = firstBtn.toString();
                            },
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          ElevatedButton.icon(
                            icon: const Icon(
                              Icons.build_sharp,
                              color: Colors.orange,
                              size: 20,
                            ),
                            label: Text(
                              secondBtn,
                              style: const TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              selectedType = secondBtn.toString();
                            },
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8, right: 2),
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    alignment: Alignment.center,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 1,
                          ),
                          ElevatedButton.icon(
                            icon: const Icon(
                              Icons.ac_unit_rounded,
                              color: Colors.orange,
                              size: 20,
                            ),
                            label: Text(
                              thirdBtn,
                              style: const TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              selectedType = thirdBtn.toString();
                            },
                          ),
                        ]),
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
                                rool = newValueSelected;
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
                  //Area
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
                            "Area Size: ",
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
                                _currentItemSelectedArea = newValueSelected!;
                                rool = newValueSelected;
                              });
                            },
                            value: _currentItemSelectedArea,
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
                  //Monthly Installment
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
                          controller: monthlyInstallmentController,
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
                            hintText: "Monthly Installment",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      )),
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
                  //Property Title
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
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Title Cannot be Empty';
                        }
                      },
                      cursorColor: const Color(0xffF5591F),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Color(0xffF5591F),
                        ),
                        hintText: "Product Title",
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
                      onPressed: propertyController.isLoading.value
                          ? null
                          : () => PropertyRegister(),
                      icon: propertyController.isLoading.value
                          ? const CircularProgressIndicator()
                          : const Icon(
                              Icons.upload,
                              color: Colors.white,
                            ),
                      label: Text(
                        propertyController.isLoading.value
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
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => context.pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => {
                  SystemChannels.platform
                      .invokeMethod<void>('SystemNavigator.pop'),
                },
                //SystemNavigator.pop(),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future PropertyRegister() async {
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
      /*   setState(() {
        _showCircle = !_showCircle;
      });*/
      propertyController.isLoading.value = true;
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = fStorage.FirebaseStorage.instance
          .ref()
          .child("Properties")
          .child(fileName);
      fStorage.UploadTask uploadTask =
          reference.putFile(File(imageXFile!.path));
      fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      await taskSnapshot.ref.getDownloadURL().then((url) {
        sellerImageUrl = url;
      });
      //EasyLoading.dismiss();
      propertyController.isLoading.value = false;
    }
    final user = FirebaseAuth.instance.currentUser!;
    late bool b ;
    if (a == "sell") {
      b = await propertyController.addProperty(
          user.uid,
          sellerImageUrl.toString(),
          selectedType,
          _currentItemSelectedLocation.toString(),
          _currentItemSelectedArea.toString(),
          int.parse(priceController.text),
          int.parse(monthlyInstallmentController.text),
          titleController.text,
          descriptionController.text,
          sellerNameController.text,
          int.parse(sellerPhoneController.text),
          _currentItemSelectedMode.toString());
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
        'propertyType': selectedType,
        'propertyCity': _currentItemSelectedLocation.toString(),
        'propertyArea': _currentItemSelectedArea.toString(),
        'propertyPrice': int.parse(priceController.text),
        'propertyInstallment': int.parse(monthlyInstallmentController.text),
        'propertyTitle': titleController.text,
        'propertyDescription': descriptionController.text,
        'propertyMode': _currentItemSelectedMode.toString(),
        "status": "inactive",
        "doc": doc,
        "type": "property",
      }).then((value) {
        propertyController.isLoading.value = false;
        b = true;
      });

    }

    if (b == true) {
      Get.snackbar(
        "Your Product is successfully",
        "added in the Database",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appScendoryColor,
        colorText: AppConstant.appTextColor,
      );
      setState(() {
        _showCircle = !_showCircle;
      });
      //   FirebaseAuth.instance.signOut();
      // Get.offAll(() => LoginScreen());
    }
  }
}
