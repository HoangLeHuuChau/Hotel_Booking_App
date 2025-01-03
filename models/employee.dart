// Model cho Employee, đại diện cho một nhân viên trong hệ thống.
class Employee {
  final int? employeeID; // ID của nhân viên, có thể null khi tạo mới.
  final String fullName; // Tên đầy đủ của nhân viên.
  final String position; // Vị trí hoặc chức danh của nhân viên.
  final String phoneNumber; // Số điện thoại liên hệ của nhân viên.
  final String email; // Email của nhân viên.

  // Constructor để khởi tạo Employee.
  Employee({
    this.employeeID,
    required this.fullName,
    required this.position,
    required this.phoneNumber,
    required this.email,
  });

  // Deserialize từ một Map (thường từ cơ sở dữ liệu).
  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      employeeID: map['employee_id'] as int?,
      fullName: map['full_name'] as String,
      position: map['position'] as String,
      phoneNumber: map['phone_number'] as String,
      email: map['email'] as String,
    );
  }

  // Serialize đối tượng Employee thành một Map để lưu vào cơ sở dữ liệu.
  Map<String, dynamic> toMap() {
    return {
      'employee_id': employeeID,
      'full_name': fullName,
      'position': position,
      'phone_number': phoneNumber,
      'email': email,
    };
  }
}