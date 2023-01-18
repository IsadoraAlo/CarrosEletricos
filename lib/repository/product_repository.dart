import '../database/database.dart';
import '../models/product.dart';

class ProductRepository {
  Future<List<Product>> listProduct() async {
    final db = await DatabaseManager().getDatabase();
    final List<Map<String, dynamic>> rows = await db.query('products');

    return rows
        .map(
          (row) => Product(
              id: row['_id'],
              descripion: row['descripion'],
              barCode: row['barCode'],
              note: row['note'],
              name: row['name'],
              image: row['image'],
              color: row['color']),
        )
        .toList();
  }
}
