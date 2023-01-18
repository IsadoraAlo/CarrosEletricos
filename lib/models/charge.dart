import 'package:flutter/material.dart';

import 'product.dart';

class Charge {
  int? id;
  Product product;
  DateTime date;
  String porcentCharged;
  Charge({
    this.id,
    required this.product,
    required this.date,
    required this.porcentCharged,
  });
}

class DataCharge {
  int percentCharged;
  int nonCharged;
  String colorCharged;
  Colors colorNonCharged;
  DataCharge({
    required this.percentCharged,
    required this.nonCharged,
    required this.colorCharged,
    required this.colorNonCharged,
  });
}
