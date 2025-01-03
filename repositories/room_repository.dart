import 'package:sqflite/sqflite.dart';
import '../data/database_config.dart';
import '../models/room.dart';
import '../interface/base_repository.dart';

// Repository xử lý các tác vụ CRUD cho Room
class RoomRepository implements BaseRepository<Room> {
  final DatabaseConfig _databaseConfig; // Cấu hình database

  // Constructor để khởi tạo RoomRepository
  RoomRepository(this._databaseConfig);

  @override
  Future<void> add(Room room) async {
    final db = await _databaseConfig.database; // Lấy instance database
    try {
      await db.insert(
        'rooms',
        room.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace, // Thay thế nếu trùng lặp
      );
      print('Room added: ${room.roomId}'); // Log thông báo khi thêm thành công
    } catch (e) {
      throw Exception('Failed to add room: $e'); // Ném lỗi nếu thêm thất bại
    }
  }

  @override
  Future<List<Room>> getAll() async {
    final db = await _databaseConfig.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('rooms'); // Lấy tất cả phòng
      return List.generate(maps.length, (i) => Room.fromMap(maps[i])); // Chuyển đổi danh sách Map thành danh sách Room
    } catch (e) {
      throw Exception('Failed to fetch room: $e'); // Ném lỗi nếu thất bại
    }
  }

  @override
  Future<Room?> findById(int id) async {
    final db = await _databaseConfig.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query(
          'rooms', where: 'room_id = ?', whereArgs: [id]); // Tìm phòng theo ID
      if (maps.isNotEmpty) {
        return Room.fromMap(maps.first); // Trả về phòng đầu tiên tìm thấy
      } else {
        return null; // Không tìm thấy phòng
      }
    } catch (e) {
      print('Room with ID $id not found'); // Log lỗi nếu không tìm thấy
      return null;
    }
  }

  @override
  Future<void> update(int id, Room room) async {
    final db = await _databaseConfig.database;
    try {
      final result = await db.update(
        'rooms',
        room.toMap(),
        where: 'room_id = ?',
        whereArgs: [id],
      );
      if (result == 0) {
        throw Exception('Room with ID $id not found for update'); // Ném lỗi nếu không tìm thấy phòng để cập nhật
      }
      print('Room updated: $id'); // Log thông báo khi cập nhật thành công
    } catch (e) {
      throw Exception('Failed to update room: $e'); // Ném lỗi nếu cập nhật thất bại
    }
  }

  @override
  Future<void> delete(int id) async {
    final db = await _databaseConfig.database;
    try {
      final result = await db.delete(
          'rooms', where: 'room_id = ?', whereArgs: [id]); // Xóa phòng theo ID
      if (result == 0) {
        throw Exception('Room with ID $id not found for deletion'); // Ném lỗi nếu không tìm thấy phòng để xóa
      }
      print('Room deleted: $id'); // Log thông báo khi xóa thành công
    } catch (e) {
      throw Exception('Failed to delete room: $e'); // Ném lỗi nếu xóa thất bại
    }
  }
}