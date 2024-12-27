import 'package:flutter/material.dart';
import '../interface/login_strategy.dart';

class AuthenticationProvider with ChangeNotifier {
  LoginStrategy? _loginStrategy;
  bool _isAuthenticated = false;
  String _username = "";

  bool get isAuthenticated => _isAuthenticated;
  String get username => _username;

  void setLoginStrategy(LoginStrategy loginStrategy) {
    _loginStrategy = loginStrategy;
  }

  Future<void> login(String username, String password) async {
    if (_loginStrategy == null) {
      throw Exception('Login strategy is not set');
    }
    _isAuthenticated = await _loginStrategy!.login(username, password);
    if (_isAuthenticated) {
      _username = username;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    if (_loginStrategy != null) {
      await _loginStrategy!.logout();
    }
    _isAuthenticated = false;
    _username = "";
    notifyListeners();
  }
}
