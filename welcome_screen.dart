import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Hình nền toàn màn hình
          Positioned.fill(
            child: Image.asset(
              'assets/images/hotel.png', // Đường dẫn tới file hình ảnh
              fit: BoxFit.cover, // Phủ kín toàn màn hình
            ),
          ),
          // Nội dung chính
          Center(
            child: Text(
              'Welcome to Hotel Booking',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Màu chữ để nổi bật trên nền
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}