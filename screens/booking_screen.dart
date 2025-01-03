import 'package:flutter/material.dart';

import '../main.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final List<Map<String, dynamic>> comments = []; // Danh sách bình luận
  final TextEditingController _commentController = TextEditingController();
  double _currentRating = 0.0; // Đánh giá hiện tại

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      color: favoriteHotels.contains(hotel)
                          ? Colors.red
                          : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        if (hotel != null) {
                          if (favoriteHotels.contains(hotel)) {
                            favoriteHotels.remove(hotel);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Đã xóa khỏi danh sách yêu thích!'),
                              ),
                            );
                          } else {
                            favoriteHotels.add(hotel);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Đã thêm vào danh sách yêu thích!'),
                              ),
                            );
                          }
                        }
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Giá phòng: ${hotel?['price'] ?? 'N/A'} VNĐ',
                style: const TextStyle(
                    fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Đánh giá và bình luận
              const Text(
                'Đánh giá và bình luận:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Hiển thị đánh giá
              Row(
                children: [
                  const Text(
                    'Đánh giá của bạn:',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 8),
                  DropdownButton<double>(
                    value: _currentRating,
                    items: List.generate(6, (index) {
                      return DropdownMenuItem<double>(
                        value: index.toDouble(),
                        child: Text('$index sao'),
                      );
                    }),
                    onChanged: (value) {
                      setState(() {
                        _currentRating = value ?? 0.0;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Danh sách bình luận
              if (comments.isNotEmpty)
                Column(
                  children: comments
                      .map(
                        (comment) => ListTile(
                      leading: const Icon(Icons.comment, color: Colors.blue),
                      title: Text(comment['user']),
                      subtitle: Text(comment['content']),
                    ),
                  )
                      .toList(),
                )
              else
                const Text(
                  'Chưa có bình luận nào.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              const SizedBox(height: 16),

              // Form thêm bình luận
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: 'Viết bình luận của bạn...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: () {
                      if (_commentController.text.trim().isNotEmpty) {
                        setState(() {
                          comments.add({
                            'user': 'Người dùng 1', // Thay bằng user thực tế
                            'content': _commentController.text.trim(),
                          });
                          _commentController.clear();
                        });
                      }
                    },
                  ),
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
    );
  }
}
