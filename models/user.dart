class User {
  final int? userId;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String role;

  User({
    this.userId,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.role,
  });

  // Deserialize JSON to User instance
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'] as int?,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String,
      role: json['role'] as String,
    );
  }

  // Serialize User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'role': role,
    };
  }
}
