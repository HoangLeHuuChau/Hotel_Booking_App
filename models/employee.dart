class Employee {
  final int? employeeID;
  final String fullName;
  final String position;
  final String phoneNumber;
  final String email;

  Employee({
    required this.employeeID,
    required this.fullName,
    required this.position,
    required this.phoneNumber,
    required this.email,
  });

  // Deserialize JSON to Employee instance
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      employeeID: json['employeeID'],
      fullName: json['fullName'],
      position: json['position'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
    );
  }

  // Serialize Employee instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'employeeID': employeeID,
      'fullName': fullName,
      'position': position,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }
}
