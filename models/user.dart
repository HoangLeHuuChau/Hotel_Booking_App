import 'dart:convert';
import 'package:crypto/crypto.dart';

class User {
  final int? userId;
  final String name;
  final String email;
  final String password; // Mã hóa SHA-256
  final String phone;
  final String role;

  User({
    this.userId,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.role,
  });

  // Deserialize from database map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['user_id'] as int?,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      phone: map['phone'] as String,
      role: map['role'] as String,
    );
  }

  // Serialize to database map
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'role': role,
    };
  }

  // Hash password
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }
}
