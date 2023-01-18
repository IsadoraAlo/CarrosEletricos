import '../database/database.dart';
import '../models/feedback.dart';
import '../models/product.dart';

class FeedbacksRepository {
  Future<List<Feedbacks>> listFeedbacks() async {
    final db = await DatabaseManager().getDatabase();
    final List<Map<String, dynamic>> rows = await db.rawQuery('''
          SELECT 
            *
          FROM feedbacks
    INNER JOIN products ON products._id = feedbacks.productId
''');
    return rows
        .map(
          (row) => Feedbacks(
            id: row['id'],
            evaluation: row['evaluation'],
            rating: row['rating'],
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

  Future<void> registerFeedbacks(Feedbacks feedback) async {
    final db = await DatabaseManager().getDatabase();

    db.insert("feedbacks", {
      "id": feedback.id,
      "evaluation": feedback.evaluation,
      "rating": feedback.rating,
      "productId": feedback.product.id,
    });
  }

  Future<void> removeFeedback(int id) async {
    final db = await DatabaseManager().getDatabase();
    await db.delete('feedbacks', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> editFeedbacks(Feedbacks feedback) async {
    final db = await DatabaseManager().getDatabase();
    return db.update(
        'feedbacks',
        {
          "id": feedback.id,
          "evaluation": feedback.evaluation,
          "rating": feedback.rating,
          "productId": feedback.product.id,
        },
        where: 'id = ?',
        whereArgs: [feedback.id]);
  }
}
