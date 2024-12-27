import 'package:flutter/material.dart';
import '../interface/login_strategy.dart';

class AuthenticationProvider with ChangeNotifier {
  LoginStrategy? _loginStrategy;
  bool _isAuthenticated = false;
  String _username = "";

  /// Trạng thái xác thực
  bool get isAuthenticated => _isAuthenticated;

  /// Tên người dùng
  String get username => _username;

  /// Thiết lập chiến lược đăng nhập (Facebook, Google, etc.)
  void setLoginStrategy(LoginStrategy loginStrategy) {
    _loginStrategy = loginStrategy;
  }

  /// Xử lý đăng nhập
  Future<void> login(String username, String password) async {
    if (_loginStrategy == null) {
      throw Exception('Login strategy is not set');
    }
    try {
      _isAuthenticated = await _loginStrategy!.login(username, password);
      if (_isAuthenticated) {
        _username = username;
        notifyListeners(); // Thông báo cho các widget lắng nghe
      }
    } catch (e) {
      _isAuthenticated = false;
      throw Exception('Login failed: $e');
    }
  }

  /// Xử lý đăng xuất
  Future<void> logout() async {
    if (_loginStrategy != null) {
      await _loginStrategy!.logout();
    }
    _isAuthenticated = false;
    _username = "";
    notifyListeners(); // Thông báo cho các widget lắng nghe
  }
}
