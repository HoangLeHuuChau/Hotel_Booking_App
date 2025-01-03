import '../models/employee.dart';
import '../interface/factory.dart';

// Factory cho Employee, tạo đối tượng Employee từ dữ liệu Map.
class EmployeeFactory extends Factory<Employee> {
  @override
  Employee create(Map<String, dynamic> data) {
    // Tạo đối tượng Employee từ Map với các trường được ánh xạ tương ứng.
    return Employee(
      employeeID: data['employeeID'] as int?, // ID của nhân viên (nullable).
      fullName: data['fullName'] as String, // Tên đầy đủ của nhân viên.
      position: data['position'] as String, // Chức danh của nhân viên.
      phoneNumber: data['phoneNumber'] as String, // Số điện thoại của nhân viên.
      email: data['email'] as String, // Email của nhân viên.
    );
  }
}