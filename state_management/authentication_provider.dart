import 'package:flutter/material.dart';
import '../services/authentication_service.dart';
import '../models/user.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthenticationService _userService;

  AuthenticationProvider(this._userService);

  User? _currentUser;
  bool _isAuthenticated = false;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Đăng nhập bằng Google
  Future<void> loginWithGoogle() async {
    _setLoading(true);
    try {
      _currentUser = await _userService.loginWithGoogle();
      _isAuthenticated = _currentUser != null;
    } catch (e) {
      print('Error during Google login: $e');
      _isAuthenticated = false;
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // Đăng xuất
  Future<void> logout() async {
    _setLoading(true);
    try {
      await _userService.logout();
      _currentUser = null;
      _isAuthenticated = false;
    } catch (e) {
      print('Error during logout: $e');
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }
}
