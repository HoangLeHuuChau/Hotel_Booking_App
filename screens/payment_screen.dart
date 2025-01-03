import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedBedType;
  int nights = 1;
  final Map<String, int> bedPrices = {
    'Single': 1000000,
    'Double': 1500000,
    'Supreme': 2000000,
  };

  int get totalPrice {
    final bedPrice = bedPrices[selectedBedType] ?? 0;
    return bedPrice * nights;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final hotel = arguments?['hotel'];

    return Scaffold(
      appBar: AppBar(title: const Text('Thanh Toán')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

            // Pricing Details Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Chi tiết giá',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedBedType,
                    items: bedPrices.keys.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text('$type - ${bedPrices[type]} VND'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedBedType = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Chọn loại giường',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Số đêm:', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              nights = int.tryParse(value) ?? 1;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tổng giá:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$totalPrice VND',
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Confirm Payment Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _handlePayment(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
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
    );
  }

  void _handlePayment(BuildContext context) {
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
}