import '../database/database.dart';
import '../models/charge.dart';
import '../models/product.dart';

class ChargeRepository {
  Future<List<Charge>> listCharge() async {
    final db = await DatabaseManager().getDatabase();
    final List<Map<String, dynamic>> rows = await db.rawQuery('''
          SELECT 
            *
          FROM charges
    INNER JOIN products ON products._id = charges.productId
''');
    return rows
        .map(
          (row) => Charge(
            id: row['id'],
            porcentCharged: row['porcentCharged'],
            date: DateTime.fromMillisecondsSinceEpoch(row['date']),
            product: Product(
                id: row['productId'],
                descripion: row['descripion'],
                barCode: row['barCode'],
                note: row['note'],
                name: row['name'],
                image: row['image'],
                color: row['color']),
          ),
        )
        .toList();
  }

  Future<void> registerCharge(Charge charge) async {
    final db = await DatabaseManager().getDatabase();
    db.insert("charges", {
      "id": charge.id,
      "porcentCharged": charge.porcentCharged,
      "date": charge.date.millisecondsSinceEpoch,
      "productId": charge.product.id,
    });
  }

  Future<void> removeCharge(int id) async {
    final db = await DatabaseManager().getDatabase();
    await db.delete('charges', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> editCharge(Charge charge) async {
    final db = await DatabaseManager().getDatabase();
    return db.update(
        'charges',
        {
          "id": charge.id,
          "porcentCharged": charge.porcentCharged,
          "date": charge.date.millisecondsSinceEpoch,
          "productId": charge.product.id,
        },
        where: 'id = ?',
        whereArgs: [charge.id]);
  }
}
