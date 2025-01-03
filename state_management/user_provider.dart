import 'package:flutter/material.dart'; // Import thư viện Flutter cho giao diện người dùng
import '../models/user.dart'; // Import model User
import '../services/user_service.dart'; // Import dịch vụ UserService để xử lý dữ liệu người dùng

// Provider để quản lý trạng thái và logic liên quan đến người dùng
class UserProvider extends ChangeNotifier {
  final UserService _userService; // Dịch vụ xử lý dữ liệu người dùng

  List<User> _users = []; // Danh sách người dùng
  User? _currentUser; // Người dùng hiện tại
  bool _isLoading = false; // Trạng thái đang tải dữ liệu
  bool _isAuthenticated = false; // Trạng thái xác thực người dùng

  UserProvider(this._userService); // Constructor nhận UserService

  // Getter để lấy danh sách người dùng
  List<User> get users => _users;
  // Getter để lấy người dùng hiện tại
  User? get currentUser => _currentUser;
  // Getter để kiểm tra trạng thái đang tải
  bool get isLoading => _isLoading;
  // Getter để kiểm tra trạng thái xác thực
  bool get isAuthenticated => _isAuthenticated;

  // Hàm nội bộ để cập nhật trạng thái đang tải
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners(); // Thông báo cho giao diện biết trạng thái đã thay đổi
  }

  // Hàm lấy danh sách người dùng từ UserService
  Future<void> fetchUsers() async {
    _setLoading(true);
    try {
      _users = await _userService.readAll(); // Lấy danh sách người dùng
    } catch (e) {
      print('Error fetching users: $e'); // In lỗi nếu có
    } finally {
      _setLoading(false);
    }
  }

  // Hàm thêm người dùng mới
  Future<void> addUser(User user) async {
    _setLoading(true);
    try {
      await _userService.create(user); // Tạo người dùng mới
      await fetchUsers(); // Cập nhật danh sách sau khi thêm
    } catch (e) {
      print('Error adding user: $e'); // In lỗi nếu có
    } finally {
      _setLoading(false);
    }
  }

  // Hàm cập nhật thông tin người dùng
  Future<void> updateUser(int id, User user) async {
    _setLoading(true);
    try {
      await _userService.update(id, user); // Cập nhật người dùng
      await fetchUsers(); // Cập nhật danh sách sau khi sửa đổi
    } catch (e) {
      print('Error updating user: $e'); // In lỗi nếu có
    } finally {
      _setLoading(false);
    }
  }

  // Hàm xóa người dùng
  Future<void> deleteUser(int id) async {
    _setLoading(true);
    try {
      await _userService.delete(id); // Xóa người dùng
      await fetchUsers(); // Cập nhật danh sách sau khi xóa
    } catch (e) {
      print('Error deleting user: $e'); // In lỗi nếu có
    } finally {
      _setLoading(false);
    }
  }

  // Hàm lấy thông tin người dùng hiện tại theo ID
  Future<void> fetchCurrentUser(int id) async {
    _setLoading(true);
    try {
      _currentUser = await _userService.readById(id); // Lấy thông tin người dùng
    } catch (e) {
      print('Error fetching current user: $e'); // In lỗi nếu có
    } finally {
      _setLoading(false);
    }
  }

  // Hàm đăng nhập và xác thực người dùng
  Future<void> login(String email, String password) async {
    _setLoading(true);
    try {
      _currentUser = await _userService.authenticate(email, password); // Xác thực người dùng
      _isAuthenticated = _currentUser != null; // Kiểm tra trạng thái xác thực
    } catch (e) {
      print('Error during login: $e'); // In lỗi nếu có
      _isAuthenticated = false; // Đặt trạng thái xác thực là false
    } finally {
      _setLoading(false);
    }
    notifyListeners(); // Thông báo trạng thái thay đổi
  }

  // Hàm đăng xuất
  void logout() {
    _currentUser = null; // Xóa thông tin người dùng hiện tại
    _isAuthenticated = false; // Đặt trạng thái xác thực là false
    notifyListeners(); // Thông báo trạng thái thay đổi
  }

  // Hàm xóa dữ liệu người dùng hiện tại
  void clearUser() {
    _currentUser = null; // Xóa thông tin người dùng hiện tại
    notifyListeners(); // Thông báo trạng thái thay đổi
  }
}