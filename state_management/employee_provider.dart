import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../services/employee_service.dart';

// Provider cho Employee, quản lý trạng thái liên quan đến nhân viên trong ứng dụng.
class EmployeeProvider extends ChangeNotifier {
  final EmployeeService _employeeService; // Service được sử dụng để gọi logic nghiệp vụ.
  List<Employee> _employees = []; // Danh sách các nhân viên hiện tại.

  // Constructor nhận service để khởi tạo.
  EmployeeProvider(this._employeeService);

  // Getter để lấy danh sách nhân viên hiện tại.
  List<Employee> get employees => _employees;

  // Phương thức fetchEmployees để tải danh sách nhân viên.
  Future<void> fetchEmployees() async {
    _employees = await _employeeService.readAll(); // Lấy danh sách nhân viên từ service.
    notifyListeners(); // Thông báo cập nhật giao diện.
  }

  // Thêm nhân viên mới.
  Future<void> addEmployee(Employee employee) async {
    await _employeeService.create(employee); // Thêm nhân viên qua service.
    await fetchEmployees(); // Tải lại danh sách nhân viên.
  }

  // Cập nhật thông tin nhân viên.
  Future<void> updateEmployee(int id, Employee employee) async {
    await _employeeService.update(id, employee); // Cập nhật nhân viên qua service.
    await fetchEmployees(); // Tải lại danh sách nhân viên.
  }

  // Xóa nhân viên theo ID.
  Future<void> deleteEmployee(int id) async {
    await _employeeService.delete(id); // Xóa nhân viên qua service.
    await fetchEmployees(); // Tải lại danh sách nhân viên.
  }
}