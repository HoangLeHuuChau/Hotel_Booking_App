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
        await db.execute('PRAGMA foreign_keys = ON');

        await db.execute('''
          CREATE TABLE users (
            user_id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            password TEXT NOT NULL,
            phone TEXT,
            role TEXT NOT NULL CHECK(role IN ('admin', 'user'))
          )
        ''');

        await db.execute('''
          CREATE TABLE hotels (
            hotel_id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            city TEXT NOT NULL,
            address TEXT NOT NULL,
            rating REAL NOT NULL CHECK(rating BETWEEN 0 AND 5)
          )
        ''');

        await db.execute('''
          CREATE TABLE rooms (
            room_id INTEGER PRIMARY KEY AUTOINCREMENT,
            hotel_id INTEGER NOT NULL,
            room_type TEXT NOT NULL,
            valid_from_type TEXT,
            valid_to_type TEXT,
            price_per_night REAL NOT NULL CHECK(price_per_night > 0),
            valid_from_price TEXT,
            valid_to_price TEXT,
            FOREIGN KEY (hotel_id) REFERENCES hotels (hotel_id) ON DELETE CASCADE
          )
        ''');

        await db.execute('''
          CREATE TABLE bookings (
            booking_id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER NOT NULL,
            room_id INTEGER NOT NULL,
            check_in_date TEXT NOT NULL,
            check_out_date TEXT NOT NULL,
            total_price REAL NOT NULL CHECK(total_price > 0),
            FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
            FOREIGN KEY (room_id) REFERENCES rooms (room_id) ON DELETE CASCADE
          )
        ''');

        await db.execute('''
          CREATE TABLE payments (
            payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
            booking_id INTEGER NOT NULL,
            amount REAL NOT NULL CHECK(amount > 0),
            payment_method TEXT NOT NULL,
            payment_date TEXT NOT NULL,
            FOREIGN KEY (booking_id) REFERENCES bookings (booking_id) ON DELETE CASCADE
          )
        ''');

        await db.execute('''
          CREATE TABLE ratings (
            rating_id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER NOT NULL,
            hotel_id INTEGER NOT NULL,
            score REAL NOT NULL CHECK(score BETWEEN 0 AND 5),
            comment TEXT,
            date TEXT NOT NULL,
            FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
            FOREIGN KEY (hotel_id) REFERENCES hotels (hotel_id) ON DELETE CASCADE
          )
        ''');

        await db.execute('''
          CREATE TABLE employees (
            employee_id INTEGER PRIMARY KEY AUTOINCREMENT,
            full_name TEXT NOT NULL,
            position TEXT NOT NULL,
            phone_number TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE
          )
        ''');

        await db.execute('''
          CREATE TABLE housekeeping_logs (
            log_id INTEGER PRIMARY KEY AUTOINCREMENT,
            room_id INTEGER NOT NULL,
            employee_id INTEGER NOT NULL,
            cleaning_date TEXT NOT NULL,
            notes TEXT,
            FOREIGN KEY (room_id) REFERENCES rooms (room_id) ON DELETE CASCADE,
            FOREIGN KEY (employee_id) REFERENCES employees (employee_id) ON DELETE CASCADE
          )
        ''');
      },
    );
  }
}
