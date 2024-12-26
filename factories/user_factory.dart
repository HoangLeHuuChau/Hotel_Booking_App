import '../models/user.dart';
import '../interface/factory.dart';

class UserFactory extends Factory<User> {
  @override
  User create(Map<String, dynamic> data) {
    return User(
      userId: data['user_id'] as int?,
      name: data['name'] as String,
      email: data['email'] as String,
      password: data['password'] as String,
      phone: data['phone'] as String,
      role: data['role'] as String,
    );
  }
}
