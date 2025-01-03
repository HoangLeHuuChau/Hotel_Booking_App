import 'package:sqflite/sqflite.dart';
import '../models/housekeeping_log.dart';
import '../data/database_config.dart';
import '../interface/base_repository.dart';

class HousekeepingLogRepository implements BaseRepository<HousekeepingLog>{
  final DatabaseConfig _databaseConfig = DatabaseConfig();

  @override
  Future<void> add(HousekeepingLog log) async {
    final db = await _databaseConfig.database;
    try {
      await db.insert('housekeeping_logs', log.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      print('Housekeeping log added: ${log.logID}');
    } catch (e) {
      throw Exception('Failed to add housekeeping log: $e');
    }
  }

  @override
  Future<List<HousekeepingLog>> getAll() async {
    final db = await _databaseConfig.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('housekeeping_logs');
      return List.generate(maps.length, (i) {
        return HousekeepingLog.fromMap(maps[i]);
      });
    } catch (e) {
      throw Exception('Failed to fetch housekeeping logs: $e');
    }
  }

  @override
  Future<void> delete(int id) async {
    final db = await _databaseConfig.database;
    try {
      final result = await db.delete('housekeeping_logs', where: 'logID = ?', whereArgs: [id]);
      if (result == 0) {
        throw Exception('Housekeeping log with ID $id not found for deletion');
      }
      print('Housekeeping log deleted: $id');
    } catch (e) {
      throw Exception('Failed to delete housekeeping log: $e');
    }
  }

  @override
  Future<void> update(int id, HousekeepingLog updatedLog) async {
    final db = await _databaseConfig.database;
    try {
      final result = await db.update(
        'housekeeping_logs',
        updatedLog.toMap(),
        where: 'logID = ?',
        whereArgs: [id],
      );
      if (result == 0) {
        throw Exception('Housekeeping log with ID $id not found for update');
      }
      print('Housekeeping log updated: $id');
    } catch (e) {
      throw Exception('Failed to update housekeeping log: $e');
    }
  }

  @override
  Future<HousekeepingLog?> findById(int id) async {
    final db = await _databaseConfig.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'housekeeping_logs',
        where: 'logID = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return HousekeepingLog.fromMap(maps.first);
      } else {
        return null;
      }
    } catch (e) {
      print('Housekeeping log with ID $id not found');
      return null;
    }
  }
}
