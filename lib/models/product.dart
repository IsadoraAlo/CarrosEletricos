// ignore_for_file: hash_and_equals

class Product {
  int? id;
  String descripion;
  String name;
  String note;
  String barCode;
  String image;
  String color;

  Product(
      {this.id,
      required this.descripion,
      required this.name,
      required this.note,
      required this.barCode,
      required this.image,
      required this.color});

  @override
  bool operator ==(Object other) => other is Product && other.id == id;
}
