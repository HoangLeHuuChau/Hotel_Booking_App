import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state_management/user_provider.dart';
import 'ChangePasswordScreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // Tính toán currentIndex
    int currentIndex = 2; // Mặc định là trang 'Profile'

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ'),
        centerTitle: true,
      ),
      body: userProvider.currentUser == null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_off, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Chưa có người dùng đăng nhập',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueAccent,
              child: Text(
                userProvider.currentUser!.name[0],
                style: const TextStyle(
                    fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              userProvider.currentUser!.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              userProvider.currentUser!.email,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.blueAccent),
              title: const Text('Đổi mật khẩu'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text('Đăng xuất'),
              onTap: () {
                // Xử lý đăng xuất
                userProvider.logout(); // Ví dụ phương thức logout
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex, // Cập nhật để mục 'Profile' được chọn
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

