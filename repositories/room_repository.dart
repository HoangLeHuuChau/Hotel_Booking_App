import 'package:sqflite/sqflite.dart';
import '../data/database_config.dart';
import '../models/room.dart';
import '../interface/base_repository.dart';

class RoomRepository implements BaseRepository<Room> {
  final DatabaseConfig _databaseConfig;

  RoomRepository(this._databaseConfig);

  @override
  Future<void> add(Room room) async {
    final db = await _databaseConfig.database;
    try {
      await db.insert('rooms', room.toMap(), conflictAlgorithm: ConflictAlgorithm.replace,);
      print('Room added: ${room.roomId}');
    } catch (e) {
      throw Exception('Failed to add room: $e');
    }
  }

  @override
  Future<List<Room>> getAll() async {
    final db = await _databaseConfig.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('rooms');
      return List.generate(maps.length, (i) => Room.fromMap(maps[i]));
    } catch (e) {
      throw Exception('Failed to fetch room: $e');
    }
  }

  @override
  Future<Room?> findById(int id) async {
    final db = await _databaseConfig.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query(
          'rooms', where: 'room_id = ?', whereArgs: [id]);
      if (maps.isNotEmpty) {
        return Room.fromMap(maps.first);
      } else {
        return null;
      }
    } catch (e) {
      print('Room with ID $id not found');
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
        throw Exception('Room with ID $id not found for update');
      }
      print('Room updated: $id');
    } catch (e) {
      throw Exception('Failed to update room: $e');
    }
  }

  @override
  Future<void> delete(int id) async {
    final db = await _databaseConfig.database;
    try {
      final result = await db.delete(
          'rooms', where: 'room_id = ?', whereArgs: [id]);
      if (result == 0) {
        throw Exception('Room with ID $id not found for deletion');
      }
      print('Room deleted: $id');
    } catch (e) {
      throw Exception('Failed to delete room: $e');
    }
  }
}
