import 'dart:convert'; // Import thư viện để xử lý mã hóa và chuyển đổi chuỗi
import 'package:crypto/crypto.dart'; // Import thư viện để sử dụng thuật toán SHA-256

// Lớp User đại diện cho một người dùng trong hệ thống
class User {
  final int? userId; // ID của người dùng (có thể null nếu là người dùng mới chưa lưu vào DB)
  final String name; // Tên của người dùng
  final String email; // Email của người dùng
  final String password; // Mật khẩu của người dùng (được băm SHA-256)
  final String phone; // Số điện thoại của người dùng
  final String role; // Vai trò của người dùng (admin hoặc user)

  // Constructor để khởi tạo đối tượng User
  User({
    this.userId, // ID có thể null (tùy thuộc vào trạng thái của người dùng trong DB)
    required this.name, // Tên là trường bắt buộc
    required this.email, // Email là trường bắt buộc
    required this.password, // Mật khẩu là trường bắt buộc
    required this.phone, // Số điện thoại là trường bắt buộc
    required this.role, // Vai trò là trường bắt buộc
  });

  // Factory constructor để tạo đối tượng User từ một Map (dùng khi lấy dữ liệu từ DB)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['user_id'] as int?, // Lấy ID từ map (có thể null)
      name: map['name'] as String, // Lấy tên từ map
      email: map['email'] as String, // Lấy email từ map
      password: map['password'] as String, // Lấy mật khẩu từ map (đã băm)
      phone: map['phone'] as String, // Lấy số điện thoại từ map
      role: map['role'] as String, // Lấy vai trò từ map
    );
  }

  // Phương thức chuyển đổi đối tượng User thành Map (dùng khi lưu vào DB)
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId, // ID của người dùng
      'name': name, // Tên của người dùng
      'email': email, // Email của người dùng
      'password': password, // Mật khẩu đã băm của người dùng
      'phone': phone, // Số điện thoại của người dùng
      'role': role, // Vai trò của người dùng
    };
  }

  // Hàm băm mật khẩu bằng thuật toán SHA-256
  static String hashPassword(String password) {
    final bytes = utf8.encode(password); // Chuyển đổi mật khẩu thành bytes
    return sha256.convert(bytes).toString(); // Băm bytes và trả về chuỗi kết quả
  }
}
