import 'package:sqflite/sqflite.dart';
import '../models/payment.dart';
import '../data/database_config.dart';
import '../interface/base_repository.dart';

// PaymentRepository chịu trách nhiệm thao tác CRUD với database cho đối tượng Payment.
class PaymentRepository implements BaseRepository<Payment> {
  final DatabaseConfig _databaseConfig = DatabaseConfig(); // Cấu hình database.

  // Thêm một thanh toán mới vào database.
  @override
  Future<void> add(Payment payment) async {
    final db = await _databaseConfig.database;
    try {
      await db.insert('payments', payment.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace); // Thêm hoặc ghi đè nếu xung đột.
      print('Payment added: ${payment.paymentID}');
    } catch (e) {
      throw Exception('Failed to add payment: $e');
    }
  }

  // Lấy danh sách tất cả các thanh toán từ database.
  @override
  Future<List<Payment>> getAll() async {
    final db = await _databaseConfig.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('payments'); // Truy vấn tất cả dữ liệu.
      return List.generate(maps.length, (i) {
        return Payment.fromMap(maps[i]); // Chuyển dữ liệu Map thành đối tượng Payment.
      });
    } catch (e) {
      throw Exception('Failed to fetch payments: $e');
    }
  }

  // Xóa một thanh toán từ database dựa vào ID.
  @override
  Future<void> delete(int id) async {
    final db = await _databaseConfig.database;
    try {
      final result = await db.delete('payments', where: 'paymentID = ?', whereArgs: [id]); // Điều kiện xóa.
      if (result == 0) {
        throw Exception('Payment with ID $id not found for deletion');
      }
      print('Payment deleted: $id');
    } catch (e) {
      throw Exception('Failed to delete payment: $e');
    }
  }

  // Cập nhật thông tin thanh toán trong database.
  @override
  Future<void> update(int id, Payment payment) async {
    final db = await _databaseConfig.database;
    try {
      final result = await db.update(
        'payments',
        payment.toMap(),
        where: 'paymentID = ?', // Điều kiện cập nhật.
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

  // Tìm một thanh toán từ database dựa vào ID.
  @override
  Future<Payment?> findById(int id) async {
    final db = await _databaseConfig.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'payments',
        where: 'paymentID = ?', // Điều kiện tìm kiếm.
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return Payment.fromMap(maps.first); // Trả về đối tượng Payment nếu tìm thấy.
      } else {
        return null; // Trả về null nếu không tìm thấy.
      }
    } catch (e) {
      print('Payment with ID $id not found');
      return null;
    }
  }
}