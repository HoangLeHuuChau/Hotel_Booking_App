import 'i_repository.dart';
import '../models/booking.dart';
import '../data/database_config.dart';

class BookingRepository implements IRepository<Booking> {
  final DatabaseConfig _dbConfig;

  BookingRepository(this._dbConfig);

  @override
  Future<List<Booking>> getAll() async {
    final db = await _dbConfig.database;
    final results = await db.query('bookings');
    return results.map((row) => Booking.fromJson(row)).toList();
  }

  @override
  Future<void> add(Booking booking) async {
    final db = await _dbConfig.database;
    await db.insert(
      'bookings',
      booking.toJson(),
    );
  }
}