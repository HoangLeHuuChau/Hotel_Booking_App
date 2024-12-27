import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state_management/authentication_provider.dart';
import '../authentication/facebook_login_strategy.dart';
import '../authentication/google_login_strategy.dart';
import '../screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    authProvider.setLoginStrategy(FacebookLoginStrategy());
                    authProvider
                        .login(
                      _usernameController.text,
                      _passwordController.text,
                    )
                        .then((_) {
                      if (authProvider.isAuthenticated) {
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    }).catchError((e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Login failed: $e')),
                      );
                    });
                  },
                  child: Text('Facebook Login'),
                ),
                ElevatedButton(
                  onPressed: () {
                    authProvider.setLoginStrategy(GoogleLoginStrategy());
                    authProvider
                        .login(
                      _usernameController.text,
                      _passwordController.text,
                    )
                        .then((_) {
                      if (authProvider.isAuthenticated) {
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    }).catchError((e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Login failed: $e')),
                      );
                    });
                  },
                  child: Text('Google Login'),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              child: Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
