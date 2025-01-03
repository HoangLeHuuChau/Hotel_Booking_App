import 'package:flutter/material.dart';
import '../main.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Danh Sách Yêu Thích',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: favoriteHotels.isEmpty
          ? const Center(
        child: Text(
          'Không có khách sạn nào trong danh sách yêu thích!',
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      )
          : ListView.builder(
        itemCount: favoriteHotels.length,
        itemBuilder: (context, index) {
          final hotel = favoriteHotels[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: Image.asset(
                hotel['image'],
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
              title: Text(hotel['name']),
              subtitle: Text('Giá: ${hotel['price']} VNĐ'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
          // Xóa khách sạn khỏi danh sách
          favoriteHotels.removeAt(index);

          // Kiểm tra xem danh sách còn phần tử nào không
          if (favoriteHotels.isEmpty) {
          // Làm mới toàn bộ màn hình
          Navigator.popAndPushNamed(context, '/favorite');
          } else {
          // Làm mới giao diện
          (context as Element).markNeedsBuild();
          }

          }

    ),

              onTap: () {
                // Chuyển sang màn hình chi tiết khách sạn
                Navigator.pushNamed(
                  context,
                  '/booking',
                  arguments: {'hotel': hotel},
                );
              },
            ),
          );
        },
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
