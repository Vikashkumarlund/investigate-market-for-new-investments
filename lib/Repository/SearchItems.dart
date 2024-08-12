class Cars {
  final String brand;
  final String model;

  Cars({required this.brand, required this.model});
}

List<Cars> studentDetails = [
  Cars(brand: "BMW", model: "X1"),
  Cars(brand: "BMW", model: "X2"),
  Cars(brand: "BMW", model: "X3"),
  Cars(brand: "MAZDA", model: "MAZDA CX-90"),
  Cars(brand: "MAZDA", model: "MAZDA CX-30"),
  Cars(brand: "MAZDA", model: "MAZDA6"),
  Cars(brand: "KIA", model: "Sportage"),
  Cars(brand: "KIA", model: "Soul"),
  Cars(brand: "KIA", model: "Sorento"),
  Cars(brand: "Infiniti", model: "Q50"),
  Cars(brand: "Infiniti", model: "QX55"),
  Cars(brand: "Infiniti", model: "QX30"),
  Cars(brand: "Lexus", model: "RX"),
  Cars(brand: "Lexus", model: "ES"),
  Cars(brand: "Lexus", model: "RZ"),
  Cars(brand: "Mercedes", model: "EQA"),
  Cars(brand: "Mercedes", model: "EQB"),
  Cars(brand: "Mercedes", model: "EQC"),
];

class Brands {
  final String title;
  final String imgName;

  Brands({required this.title, required this.imgName});
}

List<Brands> brandsDetails = [
  Brands(title: "BMW", imgName: "bmw.png"),
  Brands(title: "Mazda", imgName: "mazda.png"),
  Brands(title: "KIA", imgName: "kia.png"),
  Brands(title: "Infiniti", imgName: "infiniti.png"),
  Brands(title: "Lexus", imgName: "lexus.png"),
  Brands(title: "Mercedes", imgName: "mazda.png"),
];

class Cities {
  final String title;
  final String imgName;

  Cities({required this.title, required this.imgName});
}

List<Cities> citiesDetails = [
  Cities(title: "Lahore", imgName: "Karachi.jpg"),
  Cities(title: "Peshawar", imgName: "Peshawar.jpg"),
  Cities(title: "Islamabad", imgName: "Islamabad.jpg"),
  Cities(title: "Karachi", imgName: "Karachi.jpg"),
  Cities(title: "Sahiwal", imgName: "Sahiwal.jpg"),
  Cities(title: "Sialkot", imgName: "Karachi.jpg"),
];

class Prices {
  final String title;
  final String imgName;

  Prices({required this.title, required this.imgName});
}

List<Prices> pricesDetails = [
  Prices(title: "5 - 20 Lac", imgName: "cash.png"),
  Prices(title: "20 - 40 Lac", imgName: "cash.png"),
  Prices(title: "40 - 60 Lac", imgName: "cash.png"),
  Prices(title: "60 - 80 Lac", imgName: "cash.png"),
  Prices(title: "80 - 90 Lac", imgName: "cash.png"),
];
