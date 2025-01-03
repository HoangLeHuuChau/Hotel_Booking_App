import 'package:flutter/material.dart';
import 'package:hotel_booking_app/screens/paymentdetail_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedBedType;
  int nights = 1;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hotel?['name'] ?? 'N/A',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
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
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Tên của bạn',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Email không hợp lệ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Số điện thoại',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số điện thoại';
                  } else if (!RegExp(r'^\d{10,11}$').hasMatch(value)) {
                    return 'Số điện thoại không hợp lệ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
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
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Số đêm',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    nights = int.tryParse(value) ?? 1;
                  });
                },
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tổng giá:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      _handlePayment(context);
                    }
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

  void _handlePayment(BuildContext context) {
    final name = _nameController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentDetailScreen(
          name: name,
          email: email,
          phone: phone,
          totalPrice: totalPrice,
        ),
      ),
    );
  }

  }


void main() {
  runApp(const MaterialApp(
    home: PaymentScreen(),
  ));
}
