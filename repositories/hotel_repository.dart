import 'i_repository.dart';
import '../models/hotel.dart';
import '../data/database_config.dart';

class HotelRepository implements IRepository<Hotel> {
  final DatabaseConfig _dbConfig;

  HotelRepository(this._dbConfig);

  @override
  Future<List<Hotel>> getAll() async {
    final db = await _dbConfig.database;
    final results = await db.query('hotels');
    return results.map((row) => Hotel.fromJson(row)).toList();
  }

  @override
  Future<void> add(Hotel hotel) async {
    final db = await _dbConfig.database;
    await db.insert(
      'hotels',
      {
        'name': hotel.name,
        'city': hotel.city,
        'address': hotel.address,
        'rating': hotel.rating,
      },
    );
  }
}
