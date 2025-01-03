import '../models/user.dart'; // Import model User
import '../interface/factory.dart'; // Import lớp cơ sở Factory

// Factory để tạo đối tượng User từ dữ liệu thô
class UserFactory extends Factory<User> {
  @override
  User create(Map<String, dynamic> data) {
    return User(
      userId: data['user_id'] as int?, // Lấy ID từ dữ liệu thô
      name: data['name'] as String, // Lấy tên từ dữ liệu thô
      email: data['email'] as String, // Lấy email từ dữ liệu thô
      password: data['password'] as String, // Lấy mật khẩu từ dữ liệu thô
      phone: data['phone'] as String, // Lấy số điện thoại từ dữ liệu thô
      role: data['role'] as String, // Lấy vai trò từ dữ liệu thô
    );
  }
}
