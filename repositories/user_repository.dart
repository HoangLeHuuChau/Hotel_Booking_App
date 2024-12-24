import 'i_repository.dart';
import '../models/user.dart';
import '../data/database_config.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

// User Repository
class UserRepository implements IRepository<User> {
  final DatabaseConfig _dbConfig;

  UserRepository(this._dbConfig);

  @override
  Future<List<User>> getAll() async {
    final db = await _dbConfig.database;
    final results = await db.query('users');
    return results.map((row) => User.fromJson(row)).toList();
  }

  @override
  Future<void> add(User user) async {
    final db = await _dbConfig.database;

    // Hash the password before saving
    final hashedPassword = _hashPassword(user.password);

    await db.insert(
      'users',
      {
        'name': user.name,
        'email': user.email,
        'password': hashedPassword,
        'phone': user.phone,
        'role': user.role,
      },
    );
  }

  // Password hashing function using SHA-256
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}