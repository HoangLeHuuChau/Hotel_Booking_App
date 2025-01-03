import 'package:google_sign_in/google_sign_in.dart';
import '../interface/login_strategy.dart';

/// Chiến lược đăng nhập bằng Google
/// Implement giao diện LoginStrategy
class GoogleLoginStrategy implements LoginStrategy {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<bool> login(String username, String password) async {
    try {
      // Đăng nhập với tài khoản Google
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) {
        print('Google Sign-In was cancelled.');
        return false;
      }
      print('Logged in with Google: ${account.email}');
      return true;
    } catch (e) {
      print('Google Sign-In failed: $e');
      return false;
    }
  }

  @override
  Future<void> logout() async {
    try {
      // Đăng xuất khỏi Google
      await _googleSignIn.signOut();
      print('Logged out from Google');
    } catch (e) {
      print('Google Sign-Out failed: $e');
    }
  }
}
