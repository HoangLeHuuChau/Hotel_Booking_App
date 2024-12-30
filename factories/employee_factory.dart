import '../models/employee.dart';
import '../interface/factory.dart';

// Factory cho Employee
class EmployeeFactory extends Factory<Employee> {
  @override
  Employee create(Map<String, dynamic> data) {
    return Employee(
      employeeID: data['employeeID'] as int?,
      fullName: data['fullName'] as String,
      position: data['position'] as String,
      phoneNumber: data['phoneNumber'] as String,
      email: data['email'] as String,
    );
  }
}