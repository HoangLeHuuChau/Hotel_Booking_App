import 'package:sqflite/sqflite.dart';
import '../models/hotel.dart';
import '../data/database_config.dart';
import '../interface/base_repository.dart';

// HotelRepository là một lớp repository, quản lý truy cập cơ sở dữ liệu cho các đối tượng Hotel.
class HotelRepository implements BaseRepository<Hotel> {
  final DatabaseConfig _databaseConfig = DatabaseConfig(); // Cấu hình cơ sở dữ liệu.

  // Phương thức để thêm một khách sạn mới vào cơ sở dữ liệu.
  @override
  Future<void> add(Hotel hotel) async {
    final db = await _databaseConfig.database;
    try {
      await db.insert('hotels', hotel.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      print('Hotel added: ${hotel.hotelID}');
    } catch (e) {
      throw Exception('Failed to add hotel: $e'); // Ném lỗi nếu không thêm được khách sạn.
    }
  }

  // Phương thức để lấy tất cả các khách sạn từ cơ sở dữ liệu.
  @override
  Future<List<Hotel>> getAll() async {
    final db = await _databaseConfig.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('hotels');
      return List.generate(maps.length, (i) {
        return Hotel.fromMap(maps[i]); // Chuyển đổi mỗi bản ghi thành đối tượng Hotel.
      });
    } catch (e) {
      throw Exception('Failed to fetch hotels: $e'); // Ném lỗi nếu không lấy được dữ liệu.
    }
  }

  // Phương thức để xóa một khách sạn dựa trên ID.
  @override
  Future<void> delete(int id) async {
    final db = await _databaseConfig.database;
    try {
      final result = await db.delete('hotels', where: 'hotel_id = ?', whereArgs: [id]);
      if (result == 0) {
        throw Exception('Hotel with ID $id not found for deletion');
      }
      print('Hotel deleted with ID: $id');
    } catch (e) {
      throw Exception('Failed to delete hotel: $e'); // Ném lỗi nếu không xóa được khách sạn.
    }
  }

  // Phương thức để cập nhật thông tin khách sạn.
  @override
  Future<void> update(int id, Hotel hotel) async {
    final db = await _databaseConfig.database;
    try {
      final result = await db.update(
        'hotels',
        hotel.toMap(),
        where: 'hotel_id = ?',
        whereArgs: [id],
      );
      if (result == 0) {
        throw Exception('Hotel with ID $id not found for update');
      }
      print('Hotel updated with ID: $id');
    } catch (e) {
      throw Exception('Failed to update hotel: $e'); // Ném lỗi nếu không cập nhật được khách sạn.
    }
  }

  // Phương thức để tìm một khách sạn dựa trên ID.
  @override
  Future<Hotel?> findById(int id) async {
    final db = await _databaseConfig.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'hotels',
        where: 'hotel_id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return Hotel.fromMap(maps.first); // Trả về khách sạn nếu tìm thấy.
      } else {
        return null; // Trả về null nếu không tìm thấy.
      }
    } catch (e) {
      print('Hotel with ID $id not found');
      return null; // Trả về null nếu xảy ra lỗi.
    }
  }
}