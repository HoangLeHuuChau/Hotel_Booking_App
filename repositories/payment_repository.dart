import 'package:sqflite/sqflite.dart';
import '../models/payment.dart';
import '../data/database_config.dart';
import '../interface/base_repository.dart';

class PaymentRepository implements BaseRepository<Payment>{
  final DatabaseConfig _databaseConfig = DatabaseConfig();

  @override
  Future<void> add(Payment payment) async {
    final db = await _databaseConfig.database;
    try {
      await db.insert('payments', payment.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      print('Payment added: ${payment.paymentID}');
    } catch (e) {
      throw Exception('Failed to add payment: $e');
    }
  }

  @override
  Future<List<Payment>> getAll() async {
    final db = await _databaseConfig.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('payments');
      return List.generate(maps.length, (i) {
        return Payment.fromMap(maps[i]);
      });
    } catch (e) {
      throw Exception('Failed to fetch payments: $e');
    }
  }

  @override
  Future<void> delete(int id) async {
    final db = await _databaseConfig.database;
    try {
      final result = await db.delete('payments', where: 'paymentID = ?', whereArgs: [id]);
      if (result == 0) {
        throw Exception('Payment with ID $id not found for deletion');
      }
      print('Payment deleted: $id');
    } catch (e) {
      throw Exception('Failed to delete payment: $e');
    }
  }

  @override
  Future<void> update(int id, Payment payment) async {
    final db = await _databaseConfig.database;
    try {
      final result = await db.update(
        'payments',
        payment.toMap(),
        where: 'paymentID = ?',
        whereArgs: [id],
      );
      if (result == 0) {
        throw Exception('Payment with ID $id not found for update');
      }
      print('Payment updated: $id');
    } catch (e) {
      throw Exception('Failed to update payment: $e');
    }
  }

  @override
  Future<Payment?> findById(int id) async {
    final db = await _databaseConfig.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'payments',
        where: 'paymentID = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return Payment.fromMap(maps.first);
      } else {
        return null;
      }
    } catch (e) {
      print('Payment with ID $id not found');
      return null;
    }
  }
}
