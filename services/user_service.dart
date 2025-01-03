import '../models/user.dart';
import '../repositories/user_repository.dart';
import '../interface/base_service.dart';

class UserService implements BaseService<User>{
  final UserRepository _repository;

  UserService(this._repository);

  @override
  Future<void> create(User user) async {
    // Kiểm tra logic nghiệp vụ trước khi lưu.
    // if (user.password.length < 6) {
    //   throw Exception('Password must be at least 6 characters.');
    // }
    if (user.phone.length < 11) {
       throw Exception('Phone must be at least 10 numbers.');
      }
    await _repository.add(user);
  }

  @override
  Future<List<User>> readAll() async {
    return await _repository.getAll();
  }

  @override
  Future<User?> readById(int id) async {
    return await _repository.findById(id);
  }

  @override
  Future<void> update(int id, User user) async {
    await _repository.update(id, user);
  }

  @override
  Future<void> delete(int id) async {
    await _repository.delete(id);
  }

  Future<User?> authenticate(String email, String password) async {
    return await _repository.findByEmailAndPassword(email, password);
  }
}
