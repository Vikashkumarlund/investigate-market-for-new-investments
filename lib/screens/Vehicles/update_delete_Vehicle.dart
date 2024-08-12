import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:fyp5/screens/Vehicles/update_vehicle_record.dart';
import 'package:get/get.dart';

import '../../models/cars_model.dart';
import '../../widgets/icon_and_text_widget.dart';

class UpdateDeleteVehicle extends StatefulWidget {
  const UpdateDeleteVehicle({super.key});
  @override
  State<StatefulWidget> createState() => _UpdateDeleteVehicleState();
}

/*
Future deleteData(String id) async{
try {
  await  FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("collection_name")
      .doc(id)
      .delete();
}catch (e){
  return false;
}

try
{
  await firebase_storage.FirebaseStorage.instance.ref('/images/something.jpg').delete();
 } catch (e) {
  debugPrint('Error deleting $yourReference: $e');
}
 */
Future deleteStorageImage(String url) async {
  try {
    await firebase_storage.FirebaseStorage.instance.ref(url).delete();
    return true;
  } catch (e) {
    debugPrint('Error deleting $url: $e');
    return false;
  }
}

Future deleteData(String id) async {
  try {
    await FirebaseFirestore.instance.collection("cars").doc(id).delete();
    return true;
  } catch (e) {
    return false;
  }
}

class _UpdateDeleteVehicleState extends State<UpdateDeleteVehicle> {
  User? user = FirebaseAuth.instance.currentUser;
  late CollectionReference _collectionRef;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _collectionRef = FirebaseFirestore.instance.collection('cars');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Update & Delete Vehicles"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: _collectionRef
                      .where('sellerId', isEqualTo: user?.uid.toString())
                      .snapshots(),
                  //FirebaseFirestore.instance.collection('categories').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error"),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        height: 50,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    List<DocumentSnapshot> documents = snapshot.data!.docs;

                    return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot document = documents[index];
                            CarsModel carsModel = CarsModel(
                              sellerId: document['sellerId'],
                              imgUrl: document['imgUrl'],
                              carLocation: document['carLocation'],
                              carBrand: document['carBrand'],
                              carDesciption: document['carDesciption'],
                              carSellerName: document['carSellerName'],
                              carSellerPhone: document['carSellerPhone'],
                              carDistance: document['carDistance'],
                              carPrice: document['carPrice'],
                              carMode: document['carMode'],
                              carInstallment: document['carInstallment'],
                            );

                            return GestureDetector(
                                //You need to make my child interactive
                                /*  onTap: () =>
                                    Get.to(() => SingleVehicleDetailsScreen(
                                          carsModel: carsModel,
                                        )),*/
                                child: Container(
                              margin: EdgeInsets.only(
                                  left: 2, right: 2, bottom: 10),
                              child: Row(
                                children: [
                                  //image container
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white38,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            carsModel.imgUrl,
                                            // AppConstants.BASE_URL+AppConstants.MID_URL+productModel1.img!
                                          ),
                                        )),
                                  ),
                                  //text container
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 1, right: 1),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  iconSize: 25,
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    color: Colors.orange,
                                                  ),
                                                  // the method which is called
                                                  // when button is pressed
                                                  onPressed: () {
                                                    Get.to(() =>
                                                        UpdateVehicleRecord(
                                                            carsModel:
                                                                carsModel,
                                                            id: document.id));
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 1,
                                                ),
                                                IconButton(
                                                  iconSize: 20,
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.orange,
                                                  ),
                                                  // the method which is called
                                                  // when button is pressed
                                                  onPressed: () {
                                                    setState(
                                                      () {
                                                        deleteStorageImage(
                                                            carsModel.imgUrl
                                                                .toString());
                                                        deleteData(document.id
                                                            .toString());
                                                      },
                                                    );
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              carsModel.carBrand,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(carsModel.carPrice
                                                .toString()
                                                .toString()),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                IconAndTextWidget(
                                                    icon: Icons.location_on,
                                                    text: carsModel.carLocation,
                                                    iconColor: Colors.orange),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                IconAndTextWidget(
                                                    icon: Icons
                                                        .access_time_rounded,
                                                    text: carsModel.carDistance
                                                        .toString(),
                                                    iconColor: Colors.orange),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                          }, //item Builder
                        ));
                    return Container();
                  },
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Show Dialog"),
                ),
              ],
            ),
          ),
        ));
  }
}

// Custom dialog to update Vehicle record
/*FirebaseFirestore.instance
      .collection('Usuarios')
      .doc(uid)
      .update({'profilePic': true});

      db.collection("users").doc("docID").update({
    "field1", value1, // field, value
    "field1, "value2" // field, value
})*/

/*_displayDialog(BuildContext context, CarsModel updateCarModel) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionDuration: Duration(milliseconds: 1000),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation,
              child: child,
            ),
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          final _formKey = GlobalKey<FormState>();
          //image data
          XFile? imageXFile;
          final ImagePicker _picker = ImagePicker();

          String sellerImageUrl = "";
          Future<void> _getImage() async {
            imageXFile = await _picker.pickImage(source: ImageSource.gallery);
          }

          //dropdown menu data

          var options_location = [
            'Lahore',
            'Peshawar',
            'Islamabad',
            'Karachi',
            'Sahiwal',
            'Sialkot',
          ];
          var options_brand = [
            'BMW',
            'Mazda',
            'KIA',
            'Infiniti',
            'Lexus',
            'Mercedes'
          ];
          var _currentItemSelectedLocation = "Lahore";
          var _currentItemSelectedBrand = "BMW";

          final distanceController = TextEditingController();
          final priceController = TextEditingController();
          final descriptionController = TextEditingController();
          final sellerNameController = TextEditingController();
          final sellerPhoneController = TextEditingController();
          int maxlength = 11;

          return StatefulBuilder(
            builder: (context, StateSetter setState) {
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
                                  children: [
                                    CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width / 5,
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(
                                        updateCarModel.imgUrl,
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          _getImage();
                                          setState(() {
                                            imageXFile;
                                          });
                                        },
                                        child: CircleAvatar(
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          backgroundColor: Colors.white,
                                          backgroundImage: imageXFile == null
                                              ? null
                                              : FileImage(
                                                  File(imageXFile!.path)),
                                          child: imageXFile == null
                                              ? Icon(
                                                  Icons.add_photo_alternate,
                                                  size: MediaQuery.of(context)
                                                          .size
                                                          .width /
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
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 30),
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
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 30),
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
                                  items: options_brand
                                      .map((String dropDownStringItem) {
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
                                      _currentItemSelectedBrand =
                                          newValueSelected!;
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
                        //Kms Driven
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 30),
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
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 30),
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
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 30),
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
                              FilteringTextInputFormatter(
                                  RegExp(r'[a-zA-Z]+|\s'),
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
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 30),
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
                              FilteringTextInputFormatter(
                                  RegExp(r'[a-zA-Z]+|\s'),
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
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 30),
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
                        /*Obx(
                    () => ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (const Color(0xffF5591F)),
                        fixedSize: const Size(350, 44),
                      ),
                      onPressed: carController.isLoading.value
                          ? null
                          : () => CarRegister(),
                      icon: carController.isLoading.value
                          ? CircularProgressIndicator()
                          : Icon(
                              Icons.upload,
                              color: Colors.white,
                            ),
                      label: Text(
                        carController.isLoading.value
                            ? 'Processing'
                            : 'Post Your Ad',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),*/
                      ],
                    ),
                  ),
                )),
              );
            },
          );
        });
  }*/
