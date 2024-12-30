import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../interface/base_repository.dart';
import '../models/user.dart';

class UserRepository implements BaseRepository<User> {
  final List<User> _users = [];

  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  @override
  Future<void> add(User user) async {
    try {
      _users.add(user);
      print('User added: ${user.userId}');
    } catch (e) {
      throw Exception('Failed to add user: $e');
    }
  }

  @override
  Future<List<User>> getAll() async {
    try {
      return _users;
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      final initialLength = _users.length;
      _users.removeWhere((user) => user.userId == id);
      if (_users.length == initialLength) {
        throw Exception('User with ID $id not found for deletion');
      }
      print('User deleted: $id');
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  @override
  Future<void> update(String id, User user) async {
    try {
      final index = _users.indexWhere((u) => u.userId == id);
      if (index == -1) {
        throw Exception('User with ID $id not found for update');
      }
      _users[index] = user;
      print('User updated: $id');
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  @override
  Future<User?> findById(String id) async {
    try {
      return _users.firstWhere((user) => user.userId == id);
    } catch (e) {
      print('User with ID $id not found');
      return null;
    }
  }

  Future<User?> findByEmailAndPassword(String email, String password) async {
    final hashedPassword = hashPassword(password);
    try{
      return _users.firstWhere((user) => user.email == email && user.password == hashedPassword);
    }catch (e) {
      print('User with email $email not found or password incorrect');
      return null;
    }
  }
}
