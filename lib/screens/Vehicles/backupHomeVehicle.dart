import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/carousel_controller.dart';
import '../../models/carousel_loading.dart';
import '../../models/carousel_with_indicator.dart';
import '../../models/categories-model.dart';
import '../../utils/app-constant.dart';
import '../../widgets/custom-drawer-widget.dart';
import '../../widgets/heading-widget.dart';
import '../Authentication/LogIn.dart';
import 'SearchCarPage.dart';
import 'categories_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() => Home();
}

class Home extends State<HomeScreen> {
  var a = Get.put(CarouselController());
  FirebaseAuth auth = FirebaseAuth.instance;
  signOut() async {
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: AppConstant.appTextColor),
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: AppConstant.appScendoryColor,
                statusBarIconBrightness: Brightness.light),
            backgroundColor: AppConstant.appMainColor,
            title: Text(
              AppConstant.appMainName,
              style: TextStyle(color: AppConstant.appTextColor),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: CarSearch());
                },
                icon: Icon(Icons.search),
              ),
            ],
            /* actions: [
              GestureDetector(
                onTap: () => Get.to(() => SignUpScreen()),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.shopping_cart,
                  ),
                ),
              ),
            ],*/
          ),
          drawer: DrawerWidget(),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SafeArea(child: Obx(
                    () {
                      if (a.isLoading.value) {
                        return const Center(
                          child: CarouselLoading(),
                        );
                      } else {
                        if (a.carouselItemList.isNotEmpty) {
                          return CarouselWithIndicator(
                              data: a.carouselItemList);
                        } else {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(Icons.hourglass_empty),
                                Text("Data not found!")
                              ],
                            ),
                          );
                        }
                      }
                    },
                  )),
                  // CategoriesWidget(),
                  //heading ..According to Brand selection
                  HeadingWidget(
                    headingTitle: "Brands",
                    headingSubTitle: "Select According to Brands",
                    onTap: () => Get.to(() => CategoriesScreen(), arguments: [
                      {"first": null},
                      {"second": null},
                      {"third": null}
                    ]),
                    buttonText: "See More >",
                  ), //..According to Brand selection
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('models')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError)
                        return Text('Something went wrong');
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Text("Loading");
                      List<DocumentSnapshot> documents = snapshot.data!.docs;
                      return SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot document = documents[index];
                            return new GestureDetector(
                                //You need to make my child
                                onTap: () => Get.to(() => CategoriesScreen(),
                                        arguments: [
                                          {
                                            "first":
                                                document['title'].toString()
                                          },
                                          {"second": null},
                                          {"third": null}
                                        ]),
                                child: Container(
                                    alignment: Alignment.center,
                                    width: 100,
                                    height: 100,
                                    color: Colors.transparent,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Card(
                                        elevation: 10,
                                        //shadowColor: Colors.black,
                                        color: Colors.transparent,
                                        child: SizedBox(
                                            width: 100,
                                            height: 100,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: Column(
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl:
                                                        document['imgUrl'],
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      width: 60.0,
                                                      height: 60.0,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                    placeholder: (context,
                                                            url) =>
                                                        CircularProgressIndicator(),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                                  /* CircleAvatar(
                              backgroundColor: Colors.green[500],
                                radius: 50,
                                child: const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://media.geeksforgeeks.org/wp-content/uploads/20210101144014/gfglogo.png"), //NetworkImage
                                  radius: 50,
                                ), //CircleAvatar
                              ), */ //CircleAvatar
                                                  const SizedBox(
                                                    height: 10,
                                                  ), //SizedBox
                                                  Text(
                                                    document['title'],
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ), //Textstyle
                                                  ),
                                                ], //children
                                              ),
                                            )))));
                          }, //itembuilder
                        ),
                      );
                    },
                  ),
                  //According to cities
                  HeadingWidget(
                    headingTitle: "Cities",
                    headingSubTitle: "According to your Location",
                    onTap: () => Get.to(() => CategoriesScreen(), arguments: [
                      {"first": null},
                      {"second": null},
                      {"third": null}
                    ]),
                    buttonText: "See More >",
                  ),
                  //According to cities
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('categories')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError)
                        return Text('Something went wrong');
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Text("Loading");
                      List<DocumentSnapshot> documents = snapshot.data!.docs;
                      return SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot document = documents[index];
                            CategoriesModel categoriesModel = CategoriesModel(
                              categoryId: document['categoryId'],
                              categoryImg: document['categoryImg'],
                              categoryName: document['categoryName'],
                              createdAt: document['createdAt'],
                              updatedAt: document['updatedAt'],
                            );
                            return new GestureDetector(
                              //You need to make my child interactive
                              onTap: () =>
                                  Get.to(() => CategoriesScreen(), arguments: [
                                {"first": null},
                                {
                                  "second":
                                      categoriesModel.categoryName.toString()
                                },
                                {"third": null}
                              ]),
                              child: Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  height: 100,
                                  color: Colors.transparent,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Card(
                                      elevation: 10,
                                      //shadowColor: Colors.black,
                                      color: Colors.transparent,
                                      child: SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Column(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: categoriesModel
                                                      .categoryImg,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    width: 60.0,
                                                    height: 60.0,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                                /* CircleAvatar(
                              backgroundColor: Colors.green[500],
                                radius: 50,
                                child: const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://media.geeksforgeeks.org/wp-content/uploads/20210101144014/gfglogo.png"), //NetworkImage
                                  radius: 50,
                                ), //CircleAvatar
                              ), */ //CircleAvatar
                                                const SizedBox(
                                                  height: 10,
                                                ), //SizedBox
                                                Text(
                                                  categoriesModel.categoryName,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ), //Textstyle
                                                ),
                                              ], //children
                                            ),
                                          )))),
                            );
                          }, //itembuilder
                        ),
                      );
                    },
                  ),
                  //According to price/Budget
                  HeadingWidget(
                    headingTitle: "Budget",
                    headingSubTitle: "According to your budget",
                    onTap: () => Get.to(() => CategoriesScreen(), arguments: [
                      {"first": null},
                      {"second": null},
                      {"third": null}
                    ]),
                    buttonText: "See More >",
                  ),
                  //According to budget
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('categories')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError)
                        return Text('Something went wrong');
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Text("Loading");
                      List<DocumentSnapshot> documents = snapshot.data!.docs;
                      return SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot document = documents[index];
                            CategoriesModel categoriesModel = CategoriesModel(
                              categoryId: document['categoryId'],
                              categoryImg: document['categoryImg'],
                              categoryName: document['categoryName'],
                              createdAt: document['createdAt'],
                              updatedAt: document['updatedAt'],
                            );
                            return GestureDetector(
                              //You need to make my child interactive
                              onTap: () =>
                                  Get.to(() => CategoriesScreen(), arguments: [
                                {"first": null},
                                {"second": null},
                                {"third": categoriesModel.updatedAt.toString()}
                              ]),
                              child: Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  height: 100,
                                  color: Colors.transparent,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Card(
                                      elevation: 10,
                                      //shadowColor: Colors.black,
                                      color: Colors.transparent,
                                      child: SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  'assets/bmw.png',
                                                  fit: BoxFit.cover,
                                                  width: 60.0,
                                                  height: 60.0,
                                                ),
                                                /* CachedNetworkImage(
                                                  imageUrl: categoriesModel
                                                      .categoryImg,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    width: 60.0,
                                                    height: 60.0,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),*/
                                                /* CircleAvatar(
                              backgroundColor: Colors.green[500],
                                radius: 50,
                                child: const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://media.geeksforgeeks.org/wp-content/uploads/20210101144014/gfglogo.png"), //NetworkImage
                                  radius: 50,
                                ), //CircleAvatar
                              ), */ //CircleAvatar
                                                const SizedBox(
                                                  height: 10,
                                                ), //SizedBox
                                                Text(
                                                  categoriesModel.createdAt,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ), //Textstyle
                                                ),
                                              ], //children
                                            ),
                                          )))),
                            );
                          }, //itembuilder
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want Signout'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => {
                  signOut(),
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  ),
                },
                //SystemNavigator.pop(),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
