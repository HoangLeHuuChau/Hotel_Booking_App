import 'package:sqflite/sqflite.dart';
import '../data/database_config.dart';
import '../models/rating.dart';
import '../interface/base_repository.dart';

class RatingRepository implements BaseRepository<Rating>{
  final DatabaseConfig _databaseConfig;

  RatingRepository(this._databaseConfig);

  @override
  Future<void> add(Rating rating) async {
    final db = await _databaseConfig.database;
    try {
      await db.insert('ratings', rating.toMap(), conflictAlgorithm: ConflictAlgorithm.replace,);
      print('Rating added: ${rating.ratingID}');
    } catch (e) {
      throw Exception('Failed to add rating: $e');
    }
  }

  @override
  Future<List<Rating>> getAll() async {
    final db = await _databaseConfig.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('ratings');
      return List.generate(maps.length, (i) => Rating.fromMap(maps[i]));
    } catch (e) {
      throw Exception('Failed to fetch rating: $e');
    }
  }

  @override
  Future<Rating?> findById(int id) async {
    final db = await _databaseConfig.database;
    try{
      final List<Map<String, dynamic>> maps = await db.query('ratings', where: 'rating_id = ?', whereArgs: [id]);
      if (maps.isNotEmpty) {
        return Rating.fromMap(maps.first);
      } else {
        return null;
      }
    } catch (e) {
      print('Rating with ID $id not found');
      return null;
    }
  }

  @override
  Future<void> update(int id, Rating rating) async {
    final db = await _databaseConfig.database;
    try{
      final result = await db.update(
        'ratings',
        rating.toMap(),
        where: 'rating_id = ?',
        whereArgs: [id],
      );
      if (result == 0) {
        throw Exception('Rating with ID $id not found for update');
      }
      print('Rating updated: $id');
    } catch (e) {
      throw Exception('Failed to update rating: $e');
    }
  }

  @override
  Future<void> delete(int id) async {
    final db = await _databaseConfig.database;
    try{
      final result = await db.delete('ratings', where: 'rating_id = ?', whereArgs: [id]);
      if (result == 0) {
        throw Exception('Rating with ID $id not found for deletion');
      }
      print('Ratig deleted: $id');
    } catch (e) {
      throw Exception('Failed to delete rating: $e');
    }
  }
}
