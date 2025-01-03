import 'package:sqflite/sqflite.dart';
import '../data/database_config.dart';
import '../models/user.dart';
import '../interface/base_repository.dart';

// Repository quản lý các thao tác với cơ sở dữ liệu liên quan đến User
class UserRepository implements BaseRepository<User> {
  final DatabaseConfig _dbConfig = DatabaseConfig(); // Khởi tạo cấu hình cơ sở dữ liệu

  // Thêm người dùng mới vào cơ sở dữ liệu
  @override
  Future<void> add(User user) async {
    final db = await _dbConfig.database; // Lấy phiên bản cơ sở dữ liệu
    final hashedPassword = User.hashPassword(user.password); // Băm mật khẩu

    // Kiểm tra xem email đã tồn tại trong cơ sở dữ liệu chưa
    final existingUser = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [user.email],
    );

    if (existingUser.isNotEmpty) {
      throw Exception('Email already exists: ${user.email}'); // Ném ngoại lệ nếu email đã tồn tại
    }

    try {
      // Chèn người dùng mới vào cơ sở dữ liệu
      final result = await db.insert(
        'users',
        user.toMap()..['password'] = hashedPassword, // Chèn mật khẩu đã băm
        conflictAlgorithm: ConflictAlgorithm.replace, // Xử lý xung đột bằng cách ghi đè
      );

      if (result > 0) {
        print('User added successfully: ${user.userId}');
      } else {
        throw Exception('Failed to add user: ${user.userId}');
      }
    } catch (e) {
      throw Exception('Failed to add user: $e');
    }
  }

  // Lấy danh sách tất cả người dùng từ cơ sở dữ liệu
  @override
  Future<List<User>> getAll() async {
    final db = await _dbConfig.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('users'); // Truy vấn tất cả người dùng
      return List.generate(maps.length, (i) => User.fromMap(maps[i])); // Chuyển đổi Map thành danh sách User
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }

  // Xóa người dùng khỏi cơ sở dữ liệu theo ID
  @override
  Future<void> delete(int id) async {
    final db = await _dbConfig.database;
    try {
      final result = await db.delete(
        'users',
        where: 'user_id = ?',
        whereArgs: [id],
      );
      if (result == 0) {
        throw Exception('User with ID $id not found for deletion'); // Ném ngoại lệ nếu không tìm thấy người dùng
      }
      print('User deleted: $id');
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  // Cập nhật thông tin người dùng trong cơ sở dữ liệu
  @override
  Future<void> update(int id, User user) async {
    final db = await _dbConfig.database;
    final hashedPassword = User.hashPassword(user.password); // Băm mật khẩu trước khi cập nhật
    try {
      final result = await db.update(
        'users',
        user.toMap()..['password'] = hashedPassword, // Cập nhật dữ liệu người dùng với mật khẩu đã băm
        where: 'user_id = ?',
        whereArgs: [id],
      );
      if (result == 0) {
        throw Exception('User with ID $id not found for update');
      }
      print('User updated: $id');
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  // Tìm người dùng theo ID
  @override
  Future<User?> findById(int id) async {
    final db = await _dbConfig.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'users',
        where: 'user_id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return User.fromMap(maps.first);  // Nếu tìm thấy, trả về đối tượng User
      } else {
        return null;
      }
    } catch (e) {
      print('User with ID $id not found');
      return null;
    }
  }

  // Xác thực người dùng bằng email và mật khẩu
  Future<User?> findByEmailAndPassword(String email, String password) async {
    final db = await _dbConfig.database;
    final hashedPassword = User.hashPassword(password); // Băm mật khẩu
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, hashedPassword],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first); // Nếu tìm thấy, trả về đối tượng User
    }
    return null; // Trả về null nếu không tìm thấy
  }
}