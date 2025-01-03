// Interface cho các chiến lược đăng nhập, hỗ trợ mở rộng và tích hợp nhiều phương pháp.
abstract class LoginStrategy {
  // Đăng nhập với tên người dùng và mật khẩu, trả về true nếu thành công.
  Future<bool> login(String username, String password);

  // Đăng xuất khỏi hệ thống.
  Future<void> logout();
}