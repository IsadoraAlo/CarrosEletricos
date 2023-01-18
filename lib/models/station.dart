// ignore_for_file: hash_and_equals

class Station {
  int? id;
  String name;
  String information;
  String address;
  String cellphone;
  String map;
  String connectors;
  String url;

  Station(
      {this.id,
      required this.name,
      required this.information,
      required this.address,
      required this.cellphone,
      required this.connectors,
      required this.map,
      required this.url});

  @override
  bool operator ==(Object other) => other is Station && other.id == id;
}
