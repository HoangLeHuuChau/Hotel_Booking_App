import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final Map<String, dynamic>? hotel;

  const ChatScreen({super.key, this.hotel});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = []; // Danh sách tin nhắn

  @override
  Widget build(BuildContext context) {
    final hotel = widget.hotel;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat về ${hotel?['name'] ?? 'Phòng'}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Hiển thị thông tin phòng ở đầu giao diện chat
          if (hotel != null)
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey[200],
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      hotel['image'] ?? 'assets/images/default.png',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _messages.length,
                      reverse: true, // Tin nhắn mới nhất ở dưới
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        final isUserMessage = message['sender'] == 'user';
                        final isRoomMessage = message['sender'] == 'room'; // Kiểm tra tin nhắn phòng
                        return Align(
                          alignment: isUserMessage
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              if (isRoomMessage) {
                                final selectedHotel = _searchHotels(message['text']!).first;
                                Navigator.pushNamed(
                                  context,
                                  '/hotelDetails',
                                  arguments: selectedHotel,
                                );
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isUserMessage
                                    ? Colors.blue
                                    : (isRoomMessage ? Colors.green[100] : Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                message['text'] ?? '',
                                style: TextStyle(
                                  color: isUserMessage ? Colors.white : Colors.black87,
                                  decoration: isRoomMessage
                                      ? TextDecoration.underline
                                      : TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                ],
              ),
            ),
          const Divider(height: 1),

          // Danh sách tin nhắn
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              reverse: true, // Tin nhắn mới nhất ở dưới
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUserMessage = message['sender'] == 'user';
                return Align(
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      if (message['text']?.contains('Hotel') ?? false) {
                        final selectedHotel = _searchHotels(message['text']!).first;
                        Navigator.pushNamed(
                          context,
                          '/hotelDetails',
                          arguments: selectedHotel,
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isUserMessage ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        message['text'] ?? '',
                        style: TextStyle(
                          color: isUserMessage ? Colors.white : Colors.black87,
                          decoration: (message['text']?.contains('Hotel') ?? false)
                              ? TextDecoration.underline
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Thanh nhập tin nhắn
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Nhập tin nhắn...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.insert(0, {'sender': 'user  ', 'text': text});

        // Kiểm tra nếu người dùng hỏi về phòng
        if (text.toLowerCase().contains('phòng') ||
            text.toLowerCase().contains('khách sạn')) {
          final suggestedHotels = _searchHotels(text);
          if (suggestedHotels.isNotEmpty) {
            // Thêm danh sách phòng vào tin nhắn
            _messages.insert(0, {
              'sender': 'bot',
              'text': 'Chúng tôi tìm thấy các phòng sau:',
            });
            for (var hotel in suggestedHotels) {
              _messages.insert(0, {
                'sender': 'bot',
                'text': hotel['name']!,
              });
            }
          } else {
            _messages.insert(0, {
              'sender': 'bot',
              'text': 'Rất tiếc, chúng tôi không tìm thấy phòng phù hợp.',
            });
          }
        } else {
          // Phản hồi mặc định
          _messages.insert(0, {
            'sender': 'bot',
            'text': 'Cảm ơn bạn đã quan tâm! Chúng tôi sẽ trả lời sớm nhất.',
          });
        }
      });
      _messageController.clear();
    }
  }

  // Tìm kiếm các phòng dựa trên nội dung tin nhắn
  List<Map<String, dynamic>> _searchHotels(String query) {
    final List<Map<String, dynamic>> hotels = [
      {
        "name": "Hotel Villa Rosa",
        "rating": 8.9,
        "status": "Tuyệt vời",
        "location": "Ngay trung tâm thành phố",
        "image": "assets/images/hotel1.png",
        "price": 1500000,
      },
      {
        "name": "Vaticano Julia",
        "rating": 8.9,
        "status": "Tuyệt hảo",
        "location": "Ngay gần biển",
        "image": "assets/images/hotel2.png",
        "price": 1800000,
      },
      {
        "name": "Giolli Nazionale",
        "rating": 8.5,
        "status": "Rất tốt",
        "location": "Gần điểm du lịch nổi tiếng",
        "image": "assets/images/hotel3.png",
        "price": 1200000,
      },
    ];

    // Lọc phòng phù hợp
    return hotels.where((hotel) {
      final name = hotel['name'].toLowerCase();
      final location = hotel['location'].toLowerCase();
      final queryLower = query.toLowerCase();
      return name.contains(queryLower) || location.contains(queryLower);
    }).toList();
  }
}