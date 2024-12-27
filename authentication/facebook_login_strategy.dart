import '../interface/login_strategy.dart';

class FacebookLoginStrategy implements LoginStrategy {
  @override
  Future<bool> login(String username, String password) async {
    // Fake API call
    print('Logging in with Facebook');
    await Future.delayed(Duration(seconds: 2));
    return true; // Return success
  }

  @override
  Future<void> logout() async {
    print('Logging out from Facebook');
    await Future.delayed(Duration(seconds: 1));
  }
}
