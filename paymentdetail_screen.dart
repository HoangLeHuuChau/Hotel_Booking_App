import 'package:flutter/material.dart';

class PaymentDetailScreen extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final int totalPrice;

  const PaymentDetailScreen({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
    required this.totalPrice,
  }) : super(key: key);

  void _handlePaymentMethod(BuildContext context, String method) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Thanh toán qua $method'),
        content: const Text('Thanh toán của bạn đang được xử lý...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _confirmPayment(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thanh toán thành công'),
          content: const Text('Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Đóng thông báo
                Navigator.popUntil(context, (route) => route.isFirst); // Quay về trang chủ
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết thanh toán')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Thông tin khách hàng',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Tên: $name'),
            Text('Email: $email'),
            Text('Số điện thoại: $phone'),
            const Divider(),
            Text(
              'Tổng tiền: $totalPrice VND',
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Phương thức thanh toán',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),


            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () => _confirmPayment(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'Xác nhận thanh toán',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Likes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
            // Navigate to Home
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
            // Navigate to Likes (FavoriteScreen)
              Navigator.pushNamed(context, '/favorite');
              break;
            case 2:
            // Navigate to Profile
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }
}
