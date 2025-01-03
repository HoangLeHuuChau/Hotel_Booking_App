import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> hotels = [
    {
      "name": "Hotel Villa Rosa",
      "rating": 8.9,
      "status": "Tuyệt vời",
      "location": "Ngay trung tâm thành phố",
      "image": "assets/images/hotel1.png",
      "price": 1500,
    },
    {
      "name": "Vaticano Julia",
      "rating": 8.9,
      "status": "Tuyệt hảo",
      "location": "Ngay gần biển",
      "image": "assets/images/hotel2.png",
      "price": 1800,
    },
    {
      "name": "Giolli Nazionale",
      "rating": 8.5,
      "status": "Rất tốt",
      "location": "Gần điểm du lịch nổi tiếng",
      "image": "assets/images/hotel3.png",
      "price": 1200,
    },
  ];

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredHotels = [];

  @override
  void initState() {
    super.initState();
    filteredHotels = hotels; // Khởi tạo danh sách hiển thị
  }

  void _filterHotels(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredHotels = hotels;
      });
    } else {
      setState(() {
        filteredHotels = hotels.where((hotel) {
          final name = hotel['name'].toLowerCase();
          final location = hotel['location'].toLowerCase();
          final searchQuery = query.toLowerCase();
          return name.contains(searchQuery) || location.contains(searchQuery);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tìm chỗ nghỉ lý tưởng',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        actions: [
          // Button Đăng nhập
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login'); // Chuyển đến trang đăng nhập
            },
            child: const Text(
              'Đăng nhập',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          // Button Đăng ký
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/signup'); // Chuyển đến trang đăng ký
            },
            child: const Text(
              'Đăng ký',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thanh tìm kiếm
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterHotels,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm khách sạn?',
                prefixIcon: const Icon(Icons.search, color: Colors.blue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),

          // Danh sách khách sạn
          Expanded(
            child: ListView.builder(
              itemCount: filteredHotels.length,
              itemBuilder: (context, index) {
                final hotel = filteredHotels[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  child: Row(
                    children: [
                      // Hình ảnh khách sạn
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        child: Image.asset(
                          hotel['image'],
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Thông tin khách sạn
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hotel['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      hotel['rating'].toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    hotel['status'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      size: 14, color: Colors.red),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      hotel['location'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // Hiển thị giá phòng
                              Text(
                                'Giá phòng: ${hotel['price']} VNĐ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Nút đặt phòng
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/booking',
                              arguments: {'hotel': hotel},
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                          ),
                          child: const Text(
                            'Đặt phòng',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
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
          // Xử lý chuyển đổi màn hình
          switch (index) {
            case 0:
            // Navigate to Home
              break;
            case 1:
            // Navigate to Search
              break;
            case 2:
            // Navigate to Likes
              break;
            case 3:
            // Navigate to Profile
              break;
          }
        },
      ),
    );
  }
}
