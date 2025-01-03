  import 'package:flutter/material.dart';

  import '../main.dart';

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
                    hotel?['image'] ?? 'assets/images/default.png',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),

                // Hiển thị thông tin khách sạn
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      hotel?['name'] ?? 'N/A',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        favoriteHotels.contains(hotel)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: favoriteHotels.contains(hotel) ? Colors.red : Colors.red,
                      ),
                      onPressed: () {
                        if (hotel != null) {
                          if (favoriteHotels.contains(hotel)) {
                            favoriteHotels.remove(hotel); // Xóa khỏi danh sách yêu thích
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Đã xóa khỏi danh sách yêu thích!'),
                              ),
                            );
                          } else {
                            favoriteHotels.add(hotel); // Thêm vào danh sách yêu thích
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Đã thêm vào danh sách yêu thích!'),
                              ),
                            );
                          }
                          // Cập nhật giao diện
                          (context as Element).markNeedsBuild();
                        }
                      },
                    ),
                  ],
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
                  style: const TextStyle(
                      fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),

                // Nút chuyển đến thanh toán
                // Thay thế phần hiển thị nút với cột mới
                Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/payment', // Đường dẫn tới PaymentScreen
                            arguments: {'hotel': hotel}, // Truyền thông tin khách sạn qua arguments
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding:
                          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text(
                          'Thanh Toán Đặt Phòng',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 16), // Khoảng cách giữa hai nút
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/comments', // Đường dẫn tới CommentsScreen
                            arguments: {'hotel': hotel}, // Truyền thông tin khách sạn qua arguments
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          padding:
                          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text(
                          'Xem Bình Luận',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/chat', arguments: {'hotel': hotel});
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.chat),
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
                Navigator.pushNamed(context, '/home');
                break;
              case 1:
                Navigator.pushNamed(context, '/favorite');
                break;
              case 2:
                Navigator.pushNamed(context, '/profile');
                break;
            }
          },
        ),
      );
    }
  }
