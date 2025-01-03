import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Lớp cấu hình cơ sở dữ liệu
class DatabaseConfig {
  // Tạo một instance duy nhất (singleton) của DatabaseConfig
  static final DatabaseConfig _instance = DatabaseConfig._internal();

  // Biến lưu trữ cơ sở dữ liệu
  static Database? _database;

  // Factory constructor để trả về instance duy nhất
  factory DatabaseConfig() => _instance;

  // Constructor nội bộ để đảm bảo chỉ có một instance được tạo
  DatabaseConfig._internal();

  // Getter để truy cập cơ sở dữ liệu
  Future<Database> get database async {
    // Trả về cơ sở dữ liệu nếu đã được khởi tạo
    if (_database != null) return _database!;

    // Nếu chưa, khởi tạo cơ sở dữ liệu
    _database = await _initDatabase();
    return _database!;
  }

  // Khởi tạo cơ sở dữ liệu và tạo bảng
  Future<Database> _initDatabase() async {
    try {
      // Lấy đường dẫn đến thư mục lưu trữ cơ sở dữ liệu
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'hotel_booking.db');

      // Mở cơ sở dữ liệu với các tùy chọn cấu hình
      return await openDatabase(
        path,
        version: 1, // Phiên bản cơ sở dữ liệu
        onCreate: (db, version) async {
          // Bật ràng buộc khóa ngoại
          await db.execute('PRAGMA foreign_keys = ON');
          // Tạo bảng khi cơ sở dữ liệu được tạo lần đầu
          await _createTables(db);
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          // Logic nâng cấp cơ sở dữ liệu nếu cần
          print("Database upgraded from version $oldVersion to $newVersion");
        },
      );
    } catch (e) {
      // Bắt lỗi nếu quá trình khởi tạo thất bại
      throw Exception("Failed to initialize the database: $e");
    }
  }

  // Tạo tất cả các bảng trong cơ sở dữ liệu
  Future<void> _createTables(Database db) async {
    try {
      // Tạo bảng `users`
      await db.execute('''
        CREATE TABLE IF NOT EXISTS users (
          user_id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          email TEXT NOT NULL UNIQUE,
          password TEXT NOT NULL,
          phone TEXT,
          role TEXT NOT NULL CHECK(role IN ('admin', 'user'))
        )
      ''');

      // Tạo bảng `hotels`
      await db.execute('''
        CREATE TABLE IF NOT EXISTS hotels (
          hotel_id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          city TEXT NOT NULL,
          address TEXT NOT NULL,
          rating REAL NOT NULL CHECK(rating BETWEEN 0 AND 5)
        )
      ''');

      // Tạo bảng `rooms`
      await db.execute('''
        CREATE TABLE IF NOT EXISTS rooms (
          room_id INTEGER PRIMARY KEY AUTOINCREMENT,
          hotel_id INTEGER NOT NULL,
          room_type TEXT NOT NULL,
          valid_from_type TEXT, // Kiểu loại phòng có hiệu lực từ
          valid_to_type TEXT, // Kiểu loại phòng có hiệu lực đến
          price_per_night REAL NOT NULL CHECK(price_per_night > 0),
          valid_from_price TEXT, // Giá có hiệu lực từ
          valid_to_price TEXT, // Giá có hiệu lực đến
          FOREIGN KEY (hotel_id) REFERENCES hotels (hotel_id) ON DELETE CASCADE
        )
      ''');

      // Tạo bảng `bookings`
      await db.execute('''
        CREATE TABLE IF NOT EXISTS bookings (
          booking_id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER NOT NULL,
          room_id INTEGER NOT NULL,
          check_in_date TEXT NOT NULL, // Ngày nhận phòng
          check_out_date TEXT NOT NULL, // Ngày trả phòng
          total_price REAL NOT NULL CHECK(total_price > 0),
          FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
          FOREIGN KEY (room_id) REFERENCES rooms (room_id) ON DELETE CASCADE
        )
      ''');

      // Tạo bảng `payments`
      await db.execute('''
        CREATE TABLE IF NOT EXISTS payments (
          payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
          booking_id INTEGER NOT NULL,
          amount REAL NOT NULL CHECK(amount > 0),
          payment_method TEXT NOT NULL, // Phương thức thanh toán
          payment_date TEXT NOT NULL, // Ngày thanh toán
          FOREIGN KEY (booking_id) REFERENCES bookings (booking_id) ON DELETE CASCADE
        )
      ''');

      // Tạo bảng `ratings`
      await db.execute('''
        CREATE TABLE IF NOT EXISTS ratings (
          rating_id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER NOT NULL,
          hotel_id INTEGER NOT NULL,
          score REAL NOT NULL CHECK(score BETWEEN 0 AND 5), // Điểm đánh giá
          comment TEXT, // Bình luận
          date TEXT NOT NULL, // Ngày đánh giá
          FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
          FOREIGN KEY (hotel_id) REFERENCES hotels (hotel_id) ON DELETE CASCADE
        )
      ''');

      // Tạo bảng `employees`
      await db.execute('''
        CREATE TABLE IF NOT EXISTS employees (
          employee_id INTEGER PRIMARY KEY AUTOINCREMENT,
          full_name TEXT NOT NULL, // Họ và tên nhân viên
          position TEXT NOT NULL, // Vị trí công việc
          phone_number TEXT NOT NULL, // Số điện thoại
          email TEXT NOT NULL UNIQUE // Email nhân viên
        )
      ''');

      // Tạo bảng `housekeeping_logs`
      await db.execute('''
        CREATE TABLE IF NOT EXISTS housekeeping_logs (
          log_id INTEGER PRIMARY KEY AUTOINCREMENT,
          room_id INTEGER NOT NULL,
          employee_id INTEGER NOT NULL,
          cleaning_date TEXT NOT NULL, // Ngày dọn dẹp
          notes TEXT, // Ghi chú
          FOREIGN KEY (room_id) REFERENCES rooms (room_id) ON DELETE CASCADE,
          FOREIGN KEY (employee_id) REFERENCES employees (employee_id) ON DELETE CASCADE
        )
      ''');

      // Thêm index để tối ưu hóa truy vấn
      await db.execute('CREATE INDEX IF NOT EXISTS idx_users_email ON users (email)');
      await db.execute('CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON bookings (user_id)');
      await db.execute('CREATE INDEX IF NOT EXISTS idx_rooms_hotel_id ON rooms (hotel_id)');
    } catch (e) {
      // Bắt lỗi nếu quá trình tạo bảng thất bại
      throw Exception("Failed to create tables: $e");
    }
  }
}
