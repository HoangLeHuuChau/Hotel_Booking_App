import '../models/employee.dart';
import '../repositories/employee_repository.dart';
import '../interface/base_service.dart';

// Service cho Employee, xử lý logic ứng dụng và gọi repository.
class EmployeeService implements BaseService<Employee> {
  final EmployeeRepository _repository; // Repository được sử dụng để truy cập cơ sở dữ liệu.

  // Constructor nhận repository để khởi tạo.
  EmployeeService(this._repository);

  // Thêm nhân viên mới.
  @override
  Future<void> create(Employee employee) async {
    await _repository.add(employee);
  }

  // Đọc tất cả nhân viên.
  @override
  Future<List<Employee>> readAll() async {
    return await _repository.getAll();
  }

  // Tìm nhân viên theo ID.
  @override
  Future<Employee?> readById(int id) async {
    return await _repository.findById(id);
  }

  // Cập nhật thông tin nhân viên.
  @override
  Future<void> update(int id, Employee employee) async {
    await _repository.update(id, employee);
  }

  // Xóa nhân viên.
  @override
  Future<void> delete(int id) async {
    await _repository.delete(id);
  }
}