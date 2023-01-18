import '../database/database.dart';
import '../models/user.dart';

class UserRepository {
  Future<List<User>> listUser() async {
    final db = await DatabaseManager().getDatabase();
    final List<Map<String, dynamic>> rows = await db.query('user');

    return rows
        .map((row) => User(
              id: row['id'],
              username: row['username'],
              name: row['name'],
              email: row['email'],
              password: row['password'],
            ))
        .toList();
  }

  Future<void> registerUser(User user) async {
    final db = await DatabaseManager().getDatabase();

    db.insert('user', {
      'id': user.id,
      'username': user.username,
      'name': user.name,
      'email': user.email,
      'password': user.password,
    });
  }

  Future<bool> findLogin(String email, String password) async {
    final db = await DatabaseManager().getDatabase();
    var usuario = await db.rawQuery(
        "SELECT * FROM user WHERE email = '$email' and password = '$password'");
    if (usuario.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> removeUser(int id) async {
    final db = await DatabaseManager().getDatabase();
    await db.delete('user', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> editUser(User user) async {
    final db = await DatabaseManager().getDatabase();
    return db.update(
        'user',
        {
          'id': user.id,
          'username': user.username,
          'name': user.name,
          'email': user.email,
          'password': user.password,
        },
        where: 'id = ?',
        whereArgs: [user.id]);
  }
}
