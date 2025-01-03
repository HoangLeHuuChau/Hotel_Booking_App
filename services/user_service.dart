import '../models/user.dart';
import '../repositories/user_repository.dart';
import '../interface/base_service.dart';

// Service cung cấp các logic nghiệp vụ liên quan đến User
class UserService implements BaseService<User> {
  final UserRepository _repository;

  UserService(this._repository);

  // Tạo người dùng mới
  @override
  Future<void> create(User user) async {
    // Kiểm tra logic nghiệp vụ
    if (user.phone.length > 11) {
      throw Exception('Phone number must be at most 10 digits.');
    }
    await _repository.add(user); // Gọi repository để thêm người dùng
  }

  // Lấy danh sách tất cả người dùng
  @override
  Future<List<User>> readAll() async {
    return await _repository.getAll(); // Lấy tất cả người dùng từ repository
  }

  // Lấy thông tin người dùng theo ID
  @override
  Future<User?> readById(int id) async {
    return await _repository.findById(id); // Tìm người dùng theo ID
  }

  // Cập nhật thông tin người dùng
  @override
  Future<void> update(int id, User user) async {
    await _repository.update(id, user); // Gọi repository để cập nhật người dùng
  }

  // Xóa người dùng
  @override
  Future<void> delete(int id) async {
    await _repository.delete(id); // Gọi repository để xóa người dùng
  }

  // Xác thực người dùng với email và mật khẩu
  Future<User?> authenticate(String email, String password) async {
    return await _repository.findByEmailAndPassword(email, password);
  }
}