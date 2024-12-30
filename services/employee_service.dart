import '../interface/base_service.dart';
import '../models/employee.dart';
import '../repositories/employee_repository.dart';

// Service cho Employee
class EmployeeService implements BaseService<Employee>{
final EmployeeRepository _repository;

EmployeeService(this._repository);

Future<void> create(Employee employee) async {
await _repository.add(employee);
}

Future<List<Employee>> readAll() async {
return await _repository.getAll();
}

Future<Employee?> readById(String id) async {
return await _repository.findById(id);
}

Future<void> update(String id, Employee employee) async {
await _repository.update(id, employee);
}

Future<void> delete(String id) async {
await _repository.delete(id);
}
}