// ignore_for_file: file_names

class CarsModel {
  final String sellerId;
  late final String imgUrl;
  final String carLocation;
  final String carBrand;
  final String carDesciption;
  final String carSellerName;
  final int carSellerPhone;
  final int carDistance;
  final int carPrice;
  final String carMode;
  final int carInstallment;

  CarsModel({
    required this.sellerId,
    required this.imgUrl,
    required this.carLocation,
    required this.carBrand,
    required this.carDesciption,
    required this.carSellerName,
    required this.carSellerPhone,
    required this.carDistance,
    required this.carPrice,
    required this.carMode,
    required this.carInstallment,
  });

  // Serialize the UserModel instance to a JSON map// for saving data to the database...map model to Json
  Map<String, dynamic> toMap() {
    return {
      'sellerId': sellerId,
      'imgUrl': imgUrl,
      'carLocation': carLocation,
      'carBrand': carBrand,
      'carDesciption': carDesciption,
      'carSellerName': carSellerName,
      'carSellerPhone': carSellerPhone,
      'carDistance': carDistance,
      'carPrice': carPrice,
      'carMode': carMode,
      'carInstallment': carInstallment,
    };
  }

  // Create a UserModel instance from a JSON map// For getting data from database and map JSON to model
  factory CarsModel.fromMap(Map<String, dynamic> json) {
    return CarsModel(
      sellerId: json['sellerId'],
      imgUrl: json['imgUrl'],
      carLocation: json['carLocation'],
      carBrand: json['carBrand'],
      carDesciption: json['carDesciption'],
      carSellerName: json['carSellerName'],
      carSellerPhone: json['carSellerPhone'],
      carDistance: json['carDistance'],
      carPrice: json['carPrice'],
      carMode: json['carMode'],
      carInstallment: json['carInstallment'],
    );
  }
}
