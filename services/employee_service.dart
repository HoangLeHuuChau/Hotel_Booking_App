import '../models/employee.dart';
import '../repositories/employee_repository.dart';
import '../interface/base_service.dart';

class EmployeeService implements BaseService<Employee>{
  final EmployeeRepository _repository;

  EmployeeService(this._repository);

  @override
  Future<void> create(Employee employee) async {
    await _repository.add(employee);
  }

  @override
  Future<List<Employee>> readAll() async {
    return await _repository.getAll();
  }

  @override
  Future<Employee?> readById(int id) async {
    return await _repository.findById(id);
  }

  @override
  Future<void> update(int id, Employee employee) async {
    await _repository.update(id, employee);
  }

  @override
  Future<void> delete(int id) async {
    await _repository.delete(id);
  }
}
