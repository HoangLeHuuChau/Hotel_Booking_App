import 'package:sqflite/sqflite.dart';
import '../data/database_config.dart';
import '../models/booking.dart';
import '../interface/base_repository.dart';

class BookingRepository implements BaseRepository<Booking> {
  final DatabaseConfig _databaseConfig = DatabaseConfig();

  @override
  Future<void> add(Booking booking) async {
    final db = await _databaseConfig.database;
    try {
      await db.insert('bookings', booking.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,);
      print('Booking added: ${booking.bookingId}');
    } catch (e) {
      throw Exception('Failed to add booking: $e');
    }
  }

  @override
  Future<List<Booking>> getAll() async {
    final db = await _databaseConfig.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('bookings');
      return List.generate(maps.length, (i) => Booking.fromMap(maps[i]));
    } catch (e) {
      throw Exception('Failed to fetch booking: $e');
    }
  }

  @override
  Future<void> delete(int id) async {
    final db = await _databaseConfig.database;
    try {
      final result = await db.delete(
          'bookings', where: 'booking_id = ?', whereArgs: [id]);
      if (result == 0) {
        throw Exception('Booking with ID $id not found for deletion');
      }
      print('Booking deleted: $id');
    } catch (e) {
      throw Exception('Failed to delete booking: $e');
    }
  }

  @override
  Future<void> update(int id, Booking booking) async {
    final db = await _databaseConfig.database;
    try {
      final result = await db.update(
        'bookings',
        booking.toMap(),
        where: 'booking_id = ?',
        whereArgs: [id],
      );
      if (result == 0) {
        throw Exception('Booking with ID $id not found for update');
      }
      print('Booking updated: $id');
    } catch (e) {
      throw Exception('Failed to update booking: $e');
    }
  }

  @override
  Future<Booking?> findById(int id) async {
    final db = await _databaseConfig.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query(
          'bookings', where: 'booking_id = ?', whereArgs: [id]);
      if (maps.isNotEmpty) {
        return Booking.fromMap(maps.first);
      } else {
        return null;
      }
    } catch (e) {
      print('Booking with ID $id not found');
      return null;
    }
  }
}
