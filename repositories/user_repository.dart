import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'base_repository.dart';
import '../models/user.dart';

class UserRepository extends BaseRepository<User> {
  final List<User> _users = [];

  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  @override
  Future<void> add(User user) async {
    _users.add(user);
  }

  @override
  Future<List<User>> getAll() async {
    return _users;
  }

  @override
  Future<void> delete(String id) async {
    _users.removeWhere((user) => user.userId == id);
  }

  @override
  Future<void> update(String id, User user) async {
    final index = _users.indexWhere((u) => u.userId == id);
    if (index != -1) {
      _users[index] = user;
    }
  }

  @override
  Future<User?> findById(String id) async {
    try{
      return _users.firstWhere((user) => user.userId == id);
    }catch (e) {
      return null;
    }
  }

  Future<User?> findByEmailAndPassword(String email, String password) async {
    final hashedPassword = hashPassword(password);
    try{
      return _users.firstWhere((user) => user.email == email && user.password == hashedPassword);
    }catch (e) {
      return null;
    }
  }
}
