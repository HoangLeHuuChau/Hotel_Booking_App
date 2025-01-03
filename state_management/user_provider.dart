import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService;

  List<User> _users = [];
  User? _currentUser;
  bool _isLoading = false;
  bool _isAuthenticated = false;

  UserProvider(this._userService);

  List<User> get users => _users;
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchUsers() async {
    _setLoading(true);
    try {
      _users = await _userService.readAll();
    } catch (e) {
      print('Error fetching users: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addUser(User user) async {
    _setLoading(true);
    try {
      await _userService.create(user);
      await fetchUsers();
    } catch (e) {
      print('Error adding user: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateUser(int id, User user) async {
    _setLoading(true);
    try {
      await _userService.update(id, user);
      await fetchUsers();
    } catch (e) {
      print('Error updating user: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteUser(int id) async {
    _setLoading(true);
    try {
      await _userService.delete(id);
      await fetchUsers();
    } catch (e) {
      print('Error deleting user: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchCurrentUser(int id) async {
    _setLoading(true);
    try {
      _currentUser = await _userService.readById(id);
    } catch (e) {
      print('Error fetching current user: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> login(String email, String password) async {
    _setLoading(true);
    try {
      _currentUser = await _userService.authenticate(email, password);
      _isAuthenticated = _currentUser != null;
    } catch (e) {
      print('Error during login: $e');
      _isAuthenticated = false;
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  void clearUser() {
    _currentUser = null;
    notifyListeners();
  }
}
