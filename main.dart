import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state_management/authentication_provider.dart';
import 'state_management/user_provider.dart';
import '../services/user_service.dart'; // Ensure this is correctly imported
import '../repositories/user_repository.dart'; // Ensure this is correctly imported
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/signup_screen.dart'; // Thêm màn hình SignUp nếu cần

void main() {
  final userRepository = UserRepository();  // Create instance of UserRepository
  final userService = UserService(userRepository);  // Pass userRepository to UserService

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider(userService)),  // Pass userService here
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotel Booking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(), // Đảm bảo đăng ký route này
        '/booking': (context) => BookingScreen(),
        '/payment': (context) => PaymentScreen(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('404: Page not found'),
          ),
        ),
      ),
    );
  }
}
