import '../interface/base_service.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class UserService implements BaseService<User> {
  final UserRepository _repository;

  UserService(this._repository);

  @override
  Future<void> create(User user) async {
    // Thêm logic nghiệp vụ nếu cần trước khi lưu vào repository.
    await _repository.add(user);
  }

  @override
  Future<List<User>> readAll() async {
    return await _repository.getAll();
  }

  @override
  Future<User?> readById(String id) async {
    return await _repository.findById(id);
  }

  @override
  Future<void> update(String id, User user) async {
    // Thêm logic nghiệp vụ nếu cần trước khi cập nhật.
    await _repository.update(id, user);
  }

  @override
  Future<void> delete(String id) async {
    // Thêm logic nghiệp vụ nếu cần trước khi xóa.
    await _repository.delete(id);
  }
}
