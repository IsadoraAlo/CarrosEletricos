import 'product.dart';

class Feedbacks {
  int? id;
  String evaluation;
  String rating;
  Product product;
  Feedbacks({
    this.id,
    required this.evaluation,
    required this.rating,
    required this.product,
  });
}
