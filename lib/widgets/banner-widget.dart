// ignore_for_file: file_names, unused_field, avoid_unnecessary_containers, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fyp5/controllers/controllers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/banners-controller.dart';
import '../models/carousel_loading.dart';
import '../models/carousel_with_indicator.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  //final CarouselController carouselController = CarouselController();
  //final bannerController _bannerController = Get.put(bannerController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
            () {
          if (carouselController.isLoading.value) {
            return const Center(
              child: CarouselLoading(),
            );
          } else {
            if (carouselController.carouselItemList.isNotEmpty) {
              return CarouselWithIndicator(
                  data: carouselController.carouselItemList);
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
      ),
    );
  }
}
