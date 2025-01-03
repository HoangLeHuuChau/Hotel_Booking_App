import '../repositories/user_repository.dart';
import '../models/user.dart';
import '../interface/login_strategy.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final UserRepository _repository;
  final LoginStrategy _loginStrategy;

  AuthenticationService(this._repository, this._loginStrategy);

  // Đăng nhập bằng Google
  Future<User?> loginWithGoogle() async {
    final isLoggedIn = await _loginStrategy.login('', ''); // Google không cần username/password
    if (!isLoggedIn) {
      throw Exception('Google login failed.');
    }

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? account = await googleSignIn.signIn();

    if (account == null) {
      throw Exception('Google Sign-In was cancelled.');
    }

    final String name = account.displayName ?? 'Unknown';
    final String email = account.email;
    final String googleId = account.id;

    // Kiểm tra xem người dùng đã tồn tại trong DB
    User? existingUser = await _repository.findByEmailAndPassword(email, googleId);

    if (existingUser == null) {
      // Nếu chưa có, thêm người dùng mới vào cơ sở dữ liệu
      final newUser = User(
        name: name,
        email: email,
        password: googleId, // Sử dụng Google ID làm mật khẩu
        phone: '', // Có thể cập nhật sau
        role: 'user', // Vai trò mặc định
      );
      await _repository.add(newUser);
      existingUser = newUser;
    }

    return existingUser;
  }

  // Đăng xuất
  Future<void> logout() async {
    await _loginStrategy.logout();
  }
}
