import 'package:flutter/material.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final List<Map<String, dynamic>> comments = []; // Lưu trữ tất cả bình luận
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  int _rating = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bình luận',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: comments.isEmpty
                  ? const Center(
                child: Text(
                  'Chưa có bình luận nào.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          comment['author'][0],
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.blue,
                      ),
                      title: Text(
                        comment['author'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(comment['content']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          5,
                              (starIndex) => Icon(
                            starIndex < comment['rating']
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.yellow,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            // Form nhập bình luận
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _authorController,
                    decoration: const InputDecoration(
                      labelText: 'Tên của bạn',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tên của bạn';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _contentController,
                    decoration: const InputDecoration(
                      labelText: 'Nội dung bình luận',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập nội dung bình luận';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Text(
                        'Đánh giá:',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      DropdownButton<int>(
                        value: _rating,
                        onChanged: (value) {
                          setState(() {
                            _rating = value!;
                          });
                        },
                        items: List.generate(
                          5,
                              (index) => DropdownMenuItem(
                            value: index + 1,
                            child: Text('${index + 1} sao'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          // Thêm bình luận vào danh sách chung
                          comments.add({
                            'author': _authorController.text,
                            'content': _contentController.text,
                            'rating': _rating,
                          });
                        });

                        // Dọn dẹp các trường nhập liệu sau khi gửi bình luận
                        _authorController.clear();
                        _contentController.clear();

                        // Hiển thị thông báo cho người dùng
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Bình luận của bạn đã được thêm!'),
                          ),
                        );
                      }
                    },
                    child: const Text('Gửi bình luận'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
