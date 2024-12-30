import '../interface/base_repository.dart';
import '../models/employee.dart';

// Repository cho Employee
class EmployeeRepository implements BaseRepository<Employee> {
  final List<Employee> _employees = [];

  @override
  Future<void> add(Employee employee) async {
    try {
      _employees.add(employee);
      print('Added employee: ${employee.employeeID}');
    } catch (e) {
      throw Exception('Failed to add employee: $e');
    }
  }

  @override
  Future<List<Employee>> getAll() async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulate delay
    return _employees;
  }

  @override
  Future<void> delete(String id) async {
    try {
      final initialLength = _employees.length;
      _employees.removeWhere((employee) => employee.employeeID.toString() == id);
      if (_employees.length == initialLength) {
        throw Exception('Employee with ID $id not found');
      }
      print('Deleted employee with ID: $id');
    } catch (e) {
      throw Exception('Failed to delete employee: $e');
    }
  }

  @override
  Future<void> update(String id, Employee employee) async {
    try {
      final index = _employees.indexWhere((e) => e.employeeID.toString() == id);
      if (index == -1) {
        throw Exception('Employee with ID $id not found for update');
      }
      _employees[index] = employee;
      print('Updated employee with ID: $id');
    } catch (e) {
      throw Exception('Failed to update employee: $e');
    }
  }

  @override
  Future<Employee?> findById(String id) async {
    try {
      return _employees.firstWhere((employee) => employee.employeeID.toString() == id);
    } catch (e) {
      print('Employee with ID $id not found');
      return null;
    }
  }
}
