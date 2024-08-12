import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fyp5/controllers/update_car_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/cars_model.dart';
import '../../utils/app-constant.dart';

class UpdateVehicleRecord extends StatefulWidget {
  CarsModel carsModel;
  String id;
  UpdateVehicleRecord({super.key, required this.carsModel, required this.id});
  @override
  State<UpdateVehicleRecord> createState() => _UpdateVehicleRecordState();
}

class _UpdateVehicleRecordState extends State<UpdateVehicleRecord> {
  UpdateCarController updateCarController = Get.put(UpdateCarController());

  final _formKey = GlobalKey<FormState>();
  final distanceController = TextEditingController();
  final priceController = TextEditingController();
  final modeController = TextEditingController();
  final descriptionController = TextEditingController();
  final sellerNameController = TextEditingController();
  final sellerPhoneController = TextEditingController();
  int maxlength = 11;

  //DropDown menu
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

  //Image Data
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();
  String sellerImageUrl = "";

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentItemSelectedLocation = widget.carsModel.carLocation;
    _currentItemSelectedBrand = widget.carsModel.carBrand;
    distanceController.text = widget.carsModel.carDistance.toString();
    priceController.text = widget.carsModel.carPrice.toString();
    descriptionController.text = widget.carsModel.carDesciption.toString();
    sellerNameController.text = widget.carsModel.carSellerName.toString();
    sellerPhoneController.text = widget.carsModel.carSellerPhone.toString();
    imageXFile = null;
    sellerImageUrl = widget.carsModel.imgUrl.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: MediaQuery.of(context).size.width / 5,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                              widget.carsModel.imgUrl,
                            ),
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
                        ],
                      ),
                    ],
                  ),
                ),
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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(
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
                    items: options_location.map((String dropDownStringItem) {
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
                        _currentItemSelectedLocation = newValueSelected!;
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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(
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
                    items: options_brand.map((String dropDownStringItem) {
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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(
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
                    items: options_mode.map((String dropDownStringItem) {
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
                    hintText: "Montly Rent/Installment",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
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
              ),
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
              //Contact Information Header
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
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
              SizedBox(
                height: 10,
              ),
              Obx(
                () => ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (const Color(0xffF5591F)),
                    fixedSize: const Size(350, 44),
                  ),
                  onPressed: updateCarController.isLoading.value
                      ? null
                      : () => CarUpdate(),
                  icon: updateCarController.isLoading.value
                      ? CircularProgressIndicator()
                      : Icon(
                          Icons.upload,
                          color: Colors.white,
                        ),
                  label: Text(
                    updateCarController.isLoading.value
                        ? 'Processing'
                        : 'Update Vehicle',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future deleteStorageImage(String url) async {
    try {
      await firebase_storage.FirebaseStorage.instance.ref(url).delete();
      return true;
    } catch (e) {
      debugPrint('Error deleting $url: $e');
      return false;
    }
  }

  Future CarUpdate() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else if (imageXFile != null) {
      updateCarController.isLoading.value = true;

      /*
      Reference referenceImageToUpload =
          FirebaseStorage.instance.refFromURL(widget.carsModel.imgUrl);
      try {
        await referenceImageToUpload.putFile(File(imageXFile!.path));
        final String str = await referenceImageToUpload.getDownloadURL();
        setState(() {
          widget.carsModel.imgUrl = str;
        });

        await FirebaseFirestore.instance.terminate();
        await FirebaseFirestore.instance.clearPersistence();

        updateCarController.isLoading.value = false;
      } catch (error) {}
      updateCarController.isLoading.value = false;
    }*/
      deleteStorageImage(widget.carsModel.imgUrl.toString());
      // Call to Car register controleer
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("Vehicles")
          .child(fileName);
      firebase_storage.UploadTask uploadTask =
          reference.putFile(File(imageXFile!.path));
      firebase_storage.TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() {});
      await taskSnapshot.ref.getDownloadURL().then((url) {
        sellerImageUrl = url;
      });
    }
    final user = FirebaseAuth.instance.currentUser!;
    bool b = await updateCarController.updateCar(
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
        int.parse(modeController.text),
        widget.id.toString());
    if (b == true) {
      Get.snackbar(
        "Your Product is updated successfully",
        "added in the Database",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appScendoryColor,
        colorText: AppConstant.appTextColor,
      );
    }
  }
}
