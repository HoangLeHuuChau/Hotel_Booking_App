class Employee {
  final int? employeeID;
  final String fullName;
  final String position;
  final String phoneNumber;
  final String email;

  Employee({
    this.employeeID,
    required this.fullName,
    required this.position,
    required this.phoneNumber,
    required this.email,
  });

  // Deserialize from database map
  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      employeeID: map['employee_id'] as int?,
      fullName: map['full_name'] as String,
      position: map['position'] as String,
      phoneNumber: map['phone_number'] as String,
      email: map['email'] as String,
    );
  }

  // Serialize to database map
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
