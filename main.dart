import 'package:flutter/material.dart';
import 'package:hotel_booking_app/screens/comment_screen.dart';
import 'package:hotel_booking_app/screens/homes_screen.dart';
import 'package:provider/provider.dart';
import 'state_management/authentication_provider.dart'; // Quản lý trạng thái đăng nhập người dùng
import 'state_management/user_provider.dart'; // Quản lý thông tin người dùng
import '../services/user_service.dart'; // Dịch vụ quản lý người dùng, kết nối với repository
import '../repositories/user_repository.dart'; // Repository quản lý dữ liệu người dùng
import 'screens/welcome_screen.dart'; // Màn hình chào mừng khi mở ứng dụng
import 'screens/home_screen.dart'; // Màn hình trang chủ của ứng dụng
import 'screens/login_screen.dart'; // Màn hình đăng nhập
import 'screens/booking_screen.dart'; // Màn hình đặt phòng
import 'screens/payment_screen.dart'; // Màn hình thanh toán
import 'screens/signup_screen.dart'; // Màn hình đăng ký
import 'package:hotel_booking_app/screens/favourite_screen.dart'; // Màn hình yêu thích
import 'package:hotel_booking_app/screens/profile_screen.dart'; // Màn hình hồ sơ người dùng
import 'package:hotel_booking_app/screens/chat_screen.dart'; // Màn hình chat với khách sạn


// Danh sách toàn cục lưu khách sạn yêu thích
List<Map<String, dynamic>> favoriteHotels = [];

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider(UserService(UserRepository()))),

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
      navigatorObservers: [MyNavigatorObserver()],
      routes: {
        '/': (context) => WelcomeScreen(),
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/homes': (context) => HomeScreens(),
        '/favorite': (context) => FavoriteScreen(),
        '/profile': (context) => ProfileScreen(),
        '/signup': (context) => SignupScreen(),
        '/booking': (context) => BookingScreen(),
        '/comments': (context) => CommentsScreen(), // Thêm đường dẫn đến CommentsScreen
        '/payment': (context) => PaymentScreen(),
        '/chat': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          return ChatScreen(hotel: args?['hotel']);
        },
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

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);


  }
}

