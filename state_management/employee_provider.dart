import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../services/employee_service.dart';

class EmployeeProvider extends ChangeNotifier {
  final EmployeeService _employeeService;
  List<Employee> _employees = [];

  EmployeeProvider(this._employeeService);

  List<Employee> get employees => _employees;

  Future<void> fetchEmployees() async {
    _employees = await _employeeService.readAll();
    notifyListeners();
  }

  Future<void> addEmployee(Employee employee) async {
    await _employeeService.create(employee);
    await fetchEmployees();
  }

  Future<void> updateEmployee(int id, Employee employee) async {
    await _employeeService.update(id, employee);
    await fetchEmployees();
  }

  Future<void> deleteEmployee(int id) async {
    await _employeeService.delete(id);
    await fetchEmployees();
  }
}
