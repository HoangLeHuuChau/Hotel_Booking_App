import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

// Màn hình ChatScreen cho phép người dùng gửi và nhận tin nhắn liên quan đến một khách sạn cụ thể.
class ChatScreen extends StatefulWidget {
  final Map<String, dynamic>? hotel; // Thông tin khách sạn được truyền vào, có thể null.

  const ChatScreen({super.key, this.hotel});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController(); // Điều khiển văn bản nhập tin nhắn.
  final List<Map<String, String>> _messages = []; // Danh sách tin nhắn trong cuộc hội thoại.
  bool _isEmojiPickerVisible = false; // Trạng thái hiển thị hoặc ẩn bàn phím emoji.

  @override
  void dispose() {
    // Xóa bộ điều khiển khi widget bị hủy.
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hotel = widget.hotel; // Lấy thông tin khách sạn từ widget.

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat về ${hotel?['name'] ?? 'Phòng'}', // Hiển thị tên khách sạn trong tiêu đề.
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue, // Màu nền cho AppBar.
      ),
      body: Column(
        children: [
          if (hotel != null) _buildHotelInfo(hotel), // Hiển thị thông tin khách sạn (nếu có).
          const Divider(height: 1), // Đường ngăn cách giữa thông tin khách sạn và danh sách tin nhắn.
          _buildMessageList(), // Hiển thị danh sách tin nhắn.
          if (_isEmojiPickerVisible) _buildEmojiPicker(), // Hiển thị bàn phím emoji nếu trạng thái là true.
          _buildMessageInput(), // Khu vực nhập tin nhắn.
        ],
      ),
    );
  }

  // Widget hiển thị thông tin khách sạn (nếu có).
  Widget _buildHotelInfo(Map<String, dynamic> hotel) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey[200],
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10), // Bo tròn hình ảnh.
            child: Image.asset(
              hotel['image'] ?? 'assets/images/default.png', // Hình ảnh của khách sạn hoặc ảnh mặc định.
              height: 50,
              width: 50,
              fit: BoxFit.cover, // Điều chỉnh hình ảnh phù hợp với khung.
            ),
          ),
          const SizedBox(width: 16), // Khoảng cách giữa ảnh và văn bản.
          Expanded(
            child: Text(
              hotel['name'] ?? '', // Tên khách sạn.
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // Widget hiển thị danh sách tin nhắn.
  Widget _buildMessageList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _messages.length, // Số lượng tin nhắn.
        reverse: true, // Hiển thị tin nhắn mới nhất ở trên cùng.
        itemBuilder: (context, index) {
          final message = _messages[index];
          final isUserMessage = message['sender'] == 'user'; // Kiểm tra xem tin nhắn có phải của người dùng không.
          return Align(
            alignment: isUserMessage
                ? Alignment.centerRight // Canh phải cho tin nhắn người dùng.
                : Alignment.centerLeft, // Canh trái cho tin nhắn bot.
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Khoảng cách giữa các tin nhắn.
              padding: const EdgeInsets.all(10), // Lề bên trong cho tin nhắn.
              decoration: BoxDecoration(
                color: isUserMessage ? Colors.blue : Colors.grey[300], // Màu nền cho tin nhắn.
                borderRadius: BorderRadius.circular(10), // Bo góc tin nhắn.
              ),
              child: Text(
                message['text'] ?? '', // Nội dung tin nhắn.
                style: TextStyle(
                  color: isUserMessage ? Colors.white : Colors.black87, // Màu chữ tùy thuộc vào người gửi.
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget hiển thị bàn phím emoji.
  Widget _buildEmojiPicker() {
    return SizedBox(
      height: 300, // Chiều cao của bàn phím emoji.
      child: EmojiPicker(
        onEmojiSelected: (Category? category, Emoji emoji) {
          setState(() {
            _messageController.text += emoji.emoji ?? ''; // Thêm emoji vào trường nhập văn bản.
          });
        },
        textEditingController: _messageController, // Liên kết với TextEditingController.
        config: Config(
          checkPlatformCompatibility: true, // Kiểm tra tương thích nền tảng.
          emojiViewConfig: EmojiViewConfig(
            emojiSizeMax: 28 *
                (foundation.defaultTargetPlatform == TargetPlatform.iOS
                    ? 1.20 // Điều chỉnh kích thước cho iOS.
                    : 1.0),
          ),
          viewOrderConfig: const ViewOrderConfig(
            top: EmojiPickerItem.categoryBar, // Thanh danh mục emoji.
            middle: EmojiPickerItem.emojiView, // Khu vực hiển thị emoji.
            bottom: EmojiPickerItem.searchBar, // Thanh tìm kiếm emoji.
          ),
        ),
      ),
    );
  }

  // Widget hiển thị trường nhập tin nhắn và các nút hành động.
  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Lề bên trong.
      decoration: BoxDecoration(
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Màu bóng.
            blurRadius: 5,
            offset: const Offset(0, -2), // Đổ bóng phía trên.
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.emoji_emotions, color: Colors.blue), // Nút hiển thị bàn phím emoji.
            onPressed: () {
              setState(() {
                _isEmojiPickerVisible = !_isEmojiPickerVisible; // Đổi trạng thái hiển thị bàn phím emoji.
              });
            },
          ),
          Expanded(
            child: TextField(
              controller: _messageController, // Liên kết TextEditingController.
              decoration: const InputDecoration(
                hintText: 'Nhập tin nhắn...', // Gợi ý nhập văn bản.
                border: InputBorder.none,
              ),
              onTap: () {
                if (_isEmojiPickerVisible) {
                  setState(() {
                    _isEmojiPickerVisible = false; // Ẩn bàn phím emoji khi trường nhập được chọn.
                  });
                }
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue), // Nút gửi tin nhắn.
            onPressed: _sendMessage, // Hành động gửi tin nhắn.
          ),
        ],
      ),
    );
  }

  // Phương thức xử lý gửi tin nhắn.
  void _sendMessage() {
    final text = _messageController.text.trim(); // Lấy nội dung tin nhắn đã nhập.
    if (text.isNotEmpty) {
      final processedText = _replaceEmoticonsWithEmoji(text);
      setState(() {
        _messages.insert(0, {'sender': 'user', 'text': processedText}); // Thêm tin nhắn người dùng vào danh sách.
        _messages.insert(0, {
          'sender': 'bot',
          'text': 'Cảm ơn bạn đã gửi tin nhắn! Chúng tôi sẽ phản hồi sớm.', // Tin nhắn tự động từ bot.
        });
      });
      _messageController.clear(); // Xóa nội dung trường nhập sau khi gửi.
    }
  }

  // Bản đồ thay thế ký tự bằng emoji
  final Map<String, String> _emojiMap = {
    ':)': '😊',
    ':(': '☹️',
    ':D': '😁',
    ':P': '😋',
    ';)': '😉',
  };
  /// Hàm thay thế emoticon thành emoji
  String _replaceEmoticonsWithEmoji(String text) {
    _emojiMap.forEach((key, value) {
      text = text.replaceAll(key, value);
    });
    return text;
  }
}
