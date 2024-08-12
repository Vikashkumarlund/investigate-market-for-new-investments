// ignore_for_file: file_names

class PropertyModel {
  final String sellerId;
  final String imgUrl;
  final String propertyType;
  final String propertyCity;
  final String propertyArea;
  final int propertyPrice;
  final int propertyInstallment;
  final String propertyTitle;
  final String propertyDescription;
  final String propertySellerName;
  final int propertySellerPhone;
  final String propertyMode;

  PropertyModel(
      {required this.sellerId,
      required this.imgUrl,
      required this.propertyType,
      required this.propertyCity,
      required this.propertyArea,
      required this.propertyPrice,
      required this.propertyInstallment,
      required this.propertyTitle,
      required this.propertyDescription,
      required this.propertySellerName,
      required this.propertySellerPhone,
      required this.propertyMode});

  // Serialize the UserModel instance to a JSON map// for saving data to the database...map model to Json
  Map<String, dynamic> toMap() {
    return {
      'sellerId': sellerId,
      'imgUrl': imgUrl,
      'propertyType': propertyType,
      'propertyCity': propertyCity,
      'propertyArea': propertyArea,
      'propertyPrice': propertyPrice,
      'propertyInstallment': propertyInstallment,
      'propertyTitle': propertyTitle,
      'propertyDescription': propertyDescription,
      'propertySellerName': propertySellerName,
      'propertySellerPhone': propertySellerPhone,
      'propertyMode': propertyMode,
    };
  }

  // Create a UserModel instance from a JSON map// For getting data from database and map JSON to model
  factory PropertyModel.fromMap(Map<String, dynamic> json) {
    return PropertyModel(
      sellerId: json['sellerId'],
      imgUrl: json['imgUrl'],
      propertyType: json['propertyType'],
      propertyCity: json['propertyCity'],
      propertyArea: json['propertyArea'],
      propertyPrice: json['propertyPrice'],
      propertyInstallment: json['propertyInstallment'],
      propertyTitle: json['propertyTitle'],
      propertyDescription: json['propertyDescription'],
      propertySellerName: json['propertySellerName'],
      propertySellerPhone: json['propertySellerPhone'],
      propertyMode: json['propertyMode'],
    );
  }
}
