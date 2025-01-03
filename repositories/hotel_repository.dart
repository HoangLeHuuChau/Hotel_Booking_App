import 'package:sqflite/sqflite.dart';
import '../models/hotel.dart';
import '../data/database_config.dart';
import '../interface/base_repository.dart';

class HotelRepository implements BaseRepository<Hotel>{
  final DatabaseConfig _databaseConfig = DatabaseConfig();

  @override
  Future<void> add(Hotel hotel) async {
    final db = await _databaseConfig.database;
    try {
      await db.insert('hotels', hotel.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      print('Hotel added: ${hotel.hotelID}');
    } catch (e) {
      throw Exception('Failed to add hotel: $e');
    }
  }

  @override
  Future<List<Hotel>> getAll() async {
    final db = await _databaseConfig.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('hotels');
      return List.generate(maps.length, (i) {
        return Hotel.fromMap(maps[i]);
      });
    } catch (e) {
      throw Exception('Failed to fetch hotels: $e');
    }
  }

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
      throw Exception('Failed to delete hotel: $e');
    }
  }

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
      throw Exception('Failed to update hotel: $e');
    }
  }

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
        return Hotel.fromMap(maps.first);
      } else {
        return null;
      }
    } catch (e) {
      print('Hotel with ID $id not found');
      return null;
    }
  }
}
