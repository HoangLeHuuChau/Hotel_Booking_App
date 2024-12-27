abstract class LoginStrategy {
  Future<bool> login(String username, String password);
  Future<void> logout();
}