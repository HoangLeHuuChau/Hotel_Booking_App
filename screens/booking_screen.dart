import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Nhận dữ liệu từ arguments
    final Map<String, dynamic>? arguments =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final hotel = arguments?['hotel'];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking Room',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hiển thị hình ảnh khách sạn
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  hotel?['image'] ?? 'assets/images/default.png', // Hình mặc định nếu không có
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              // Hiển thị thông tin khách sạn
              Text(
                hotel?['name'] ?? 'N/A',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      hotel?['location'] ?? 'N/A',
                      style: const TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      hotel?['rating'].toString() ?? 'N/A',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    hotel?['status'] ?? 'N/A',
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Hiển thị giá phòng
              Text(
                'Giá phòng: ${hotel?['price'] ?? 'N/A'} VNĐ',
                style: const TextStyle(fontSize: 18,color: Colors.green, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),

              // Nút yêu thích
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Logic để thêm vào danh sách yêu thích
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    'Yêu Thích',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              // Nút chuyển đến thanh toán
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/payment', // Đường dẫn tới BookingScreen
                      arguments: {'hotel': hotel}, // Truyền thông tin khách sạn qua arguments
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    'Thanh Toán Đặt Phòng',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}