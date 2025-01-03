import 'package:sqflite/sqflite.dart';
import '../models/employee.dart';
import '../data/database_config.dart';
import '../interface/base_repository.dart';

// Repository cho Employee, xử lý các thao tác CRUD với cơ sở dữ liệu.
class EmployeeRepository implements BaseRepository<Employee> {
  final DatabaseConfig _databaseConfig = DatabaseConfig(); // Cấu hình cơ sở dữ liệu.

  // Thêm một nhân viên mới vào cơ sở dữ liệu.
  @override
  Future<void> add(Employee employee) async {
    final db = await _databaseConfig.database;
    try {
      await db.insert(
        'employees',
        employee.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Employee added: ${employee.employeeID}');
    } catch (e) {
      throw Exception('Failed to add employee: $e');
    }
  }

  // Lấy danh sách tất cả nhân viên từ cơ sở dữ liệu.
  @override
  Future<List<Employee>> getAll() async {
    final db = await _databaseConfig.database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('employees');
      return List.generate(maps.length, (i) => Employee.fromMap(maps[i]));
    } catch (e) {
      throw Exception('Failed to fetch employees: $e');
    }
  }

  // Xóa một nhân viên khỏi cơ sở dữ liệu dựa trên ID.
  @override
  Future<void> delete(int id) async {
    final db = await _databaseConfig.database;
    try {
      final result = await db.delete(
        'employees',
        where: 'employee_id = ?',
        whereArgs: [id],
      );
      if (result == 0) throw Exception('Employee with ID $id not found');
      print('Employee deleted: $id');
    } catch (e) {
      throw Exception('Failed to delete employee: $e');
    }
  }

  // Cập nhật thông tin của một nhân viên trong cơ sở dữ liệu.
  @override
  Future<void> update(int id, Employee employee) async {
    final db = await _databaseConfig.database;
    try {
      final result = await db.update(
        'employees',
        employee.toMap(),
        where: 'employee_id = ?',
        whereArgs: [id],
      );
      if (result == 0) throw Exception('Employee with ID $id not found for update');
      print('Employee updated: $id');
    } catch (e) {
      throw Exception('Failed to update employee: $e');
    }
  }

  // Tìm một nhân viên theo ID.
  @override
  Future<Employee?> findById(int id) async {
    final db = await _databaseConfig.database;
    try {
      final List<Map<String, dynamic>> maps =
      await db.query('employees', where: 'employee_id = ?', whereArgs: [id]);
      if (maps.isNotEmpty) {
        return Employee.fromMap(maps.first);
      } else {
        return null;
      }
    } catch (e) {
      print('Employee with ID $id not found');
      return null;
    }
  }
}