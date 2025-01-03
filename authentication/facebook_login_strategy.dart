import '../interface/login_strategy.dart';

/// Chiến lược đăng nhập bằng Facebook
/// Implement giao diện LoginStrategy
class FacebookLoginStrategy implements LoginStrategy {
  @override
  Future<bool> login(String username, String password) async {
    // Giả lập API call để đăng nhập với Facebook
    print('Logging in with Facebook');
    await Future.delayed(Duration(seconds: 2)); // Chờ 2 giây để mô phỏng xử lý
    return true; // Trả về thành công
  }

  @override
  Future<void> logout() async {
    // Giả lập API call để đăng xuất khỏi Facebook
    print('Logging out from Facebook');
    await Future.delayed(Duration(seconds: 1)); // Chờ 1 giây để mô phỏng xử lý
  }
}