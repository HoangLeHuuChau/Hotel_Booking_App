import '../interface/login_strategy.dart';

class GoogleLoginStrategy implements LoginStrategy {
  @override
  Future<bool> login(String username, String password) async {
    // Fake API call
    print('Logging in with Google');
    await Future.delayed(Duration(seconds: 2));
    return true; // Return success
  }

  @override
  Future<void> logout() async {
    print('Logging out from Google');
    await Future.delayed(Duration(seconds: 1));
  }
}
