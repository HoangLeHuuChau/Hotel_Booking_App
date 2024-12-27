import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService;
  List<User> _users = [];
  User? _currentUser;

  UserProvider(this._userService);

  List<User> get users => _users;
  User? get currentUser => _currentUser;

  void setUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> fetchUsers() async {
    _users = await _userService.readAll();
    notifyListeners();
  }

  Future<void> addUser(User user) async {
    await _userService.create(user);
    await fetchUsers();
  }

  Future<void> updateUser(String id, User user) async {
    await _userService.update(id, user);
    await fetchUsers();
  }

  Future<void> deleteUser(String id) async {
    await _userService.delete(id);
    await fetchUsers();
  }

  void clearUser() {
    _currentUser = null;
    notifyListeners();
  }

  Future<void> fetchCurrentUser(String id) async {
    _currentUser = await _userService.readById(id);
    notifyListeners();
  }
}