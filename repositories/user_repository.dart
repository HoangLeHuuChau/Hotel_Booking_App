import 'package:sqflite/sqflite.dart';
import '../data/database_config.dart';
import '../models/user.dart';
import '../interface/base_repository.dart';

class UserRepository implements BaseRepository<User>{
  final DatabaseConfig _dbConfig = DatabaseConfig();

  @override
  Future<void> add(User user) async {
    final db = await _dbConfig.database;
    final hashedPassword = User.hashPassword(user.password);
    try {
      await db.insert(
        'users',
        user.toMap()..['password'] = hashedPassword,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('User added: ${user.userId}');
    } catch (e) {
      throw Exception('Failed to add user: $e');
    }
  }

  @override
  Future<List<User>> getAll() async {
    final db = await _dbConfig.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('users');
      return List.generate(maps.length, (i) => User.fromMap(maps[i]));
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }

  @override
  Future<void> delete(int id) async {
    final db = await _dbConfig.database;
    try {
      final result = await db.delete(
                    'users',
                    where: 'user_id = ?',
                    whereArgs: [id],
                  );
      if (result == 0) {
        throw Exception('User with ID $id not found for deletion');
      }
      print('User deleted: $id');
    } catch (e) {
      throw Exception('Failed to delete User: $e');
    }
  }

  @override
  Future<void> update(int id, User user) async {
    final db = await _dbConfig.database;
    final hashedPassword = User.hashPassword(user.password);
    try {
      final result = await db.update(
                    'users',
                    user.toMap()..['password'] = hashedPassword,
                    where: 'user_id = ?',
                    whereArgs: [id],
                  );
      if (result == 0) {
        throw Exception('User with ID $id not found for update');
      }
      print('User updated: $id');
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  @override
  Future<User?> findById(int id) async {
    final db = await _dbConfig.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'users',
        where: 'user_id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return User.fromMap(maps.first);
      }else {
        return null;
      }
    } catch (e) {
      print('User with ID $id not found');
      return null;
    }
  }

  Future<User?> findByEmailAndPassword(String email, String password) async {
    final db = await _dbConfig.database;
    final hashedPassword = User.hashPassword(password);
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, hashedPassword],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }
}
