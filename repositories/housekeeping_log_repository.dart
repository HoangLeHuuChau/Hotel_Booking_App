import '../interface/base_repository.dart';
import '../models/housekeeping_log.dart';

// Repository cho HousekeepingLog
class HousekeepingLogRepository implements BaseRepository<HousekeepingLog> {
  final List<HousekeepingLog> _logs = [];

  @override
  Future<void> add(HousekeepingLog log) async {
    try {
      _logs.add(log);
      print('Added log: ${log.logID}');
    } catch (e) {
      throw Exception('Failed to add log: $e');
    }
  }

  @override
  Future<List<HousekeepingLog>> getAll() async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulate delay
    return _logs;
  }

  @override
  Future<void> delete(String id) async {
    try {
      final initialLength = _logs.length;
      _logs.removeWhere((log) => log.logID.toString() == id);
      if (_logs.length == initialLength) {
        throw Exception('Log with ID $id not found');
      }
      print('Deleted log with ID: $id');
    } catch (e) {
      throw Exception('Failed to delete log: $e');
    }
  }

  @override
  Future<void> update(String id, HousekeepingLog updatedLog) async {
    try {
      final index = _logs.indexWhere((log) => log.logID.toString() == id);
      if (index == -1) {
        throw Exception('Log with ID $id not found for update');
      }
      _logs[index] = updatedLog;
      print('Updated log with ID: $id');
    } catch (e) {
      throw Exception('Failed to update log: $e');
    }
  }

  @override
  Future<HousekeepingLog?> findById(String id) async {
    try {
      return _logs.firstWhere((log) => log.logID.toString() == id);
    } catch (e) {
      print('Log with ID $id not found');
      return null;
    }
  }
}