import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/carousel.dart';

class PropertyBannerService {
  final bannersRef1 = FirebaseFirestore.instance
      .collection('bannerProperty')
      .withConverter<CarouselModel>(
        fromFirestore: (snapshot, _) =>
            CarouselModel.fromJson(snapshot.data()!),
        toFirestore: (data, _) => data.toJson(),
      );

  Future<List<CarouselModel>> getBanners1() async {
    var querySnapshot = await bannersRef1.get();
    var carouselItemList = querySnapshot.docs.map((doc) => doc.data()).toList();
    return carouselItemList;
  }
}
