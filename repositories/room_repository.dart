import 'i_repository.dart';
import '../models/room.dart';
import '../data/database_config.dart';

class RoomRepository implements IRepository<Room> {
  final DatabaseConfig _dbConfig;

  RoomRepository(this._dbConfig);

  @override
  Future<List<Room>> getAll() async {
    final db = await _dbConfig.database;
    final results = await db.query('rooms');
    return results.map((row) => Room.fromJson(row)).toList();
  }

  @override
  Future<void> add(Room room) async {
    final db = await _dbConfig.database;
    await db.insert(
      'rooms',
      room.toJson(),
    );
  }
}