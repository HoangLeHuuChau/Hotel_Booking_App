import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConfig {
  static final DatabaseConfig _instance = DatabaseConfig._internal();
  static Database? _database;

  factory DatabaseConfig() => _instance;

  DatabaseConfig._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'hotel_booking.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            user_id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            password TEXT,
            phone TEXT,
            role TEXT
          )
        '''
        );

        await db.execute('''
          CREATE TABLE hotels (
            hotel_id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            city TEXT,
            address TEXT,
            rating REAL
          )
        '''
        );

        await db.execute('''
          CREATE TABLE rooms (
            room_id INTEGER PRIMARY KEY AUTOINCREMENT,
            hotel_id INTEGER,
            room_type TEXT,
            valid_from_type TEXT,
            valid_to_type TEXT,
            price_per_night REAL,
            valid_from_price TEXT,
            valid_to_price TEXT,
            FOREIGN KEY (hotel_id) REFERENCES hotels (hotel_id)
          )
        '''
        );

        await db.execute('''
          CREATE TABLE bookings (
            booking_id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER,
            room_id INTEGER,
            check_in_date TEXT,
            check_out_date TEXT,
            total_price REAL,
            FOREIGN KEY (user_id) REFERENCES users (user_id),
            FOREIGN KEY (room_id) REFERENCES rooms (room_id)
          )
        '''
        );

        await db.execute('''
          CREATE TABLE payments (
            payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
            booking_id INTEGER,
            amount REAL,
            payment_method TEXT,
            FOREIGN KEY (booking_id) REFERENCES bookings (booking_id)
          )
        '''
        );
      },
    );
  }
}