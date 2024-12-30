import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state_management/authentication_provider.dart';


class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> hotels = [
    {"name": "Hotel A", "location": "City Center"},
    {"name": "Hotel B", "location": "Near Beach"},
    {"name": "Hotel C", "location": "Mountain View"},
  ];

  //const HomeScreen({super.key});

  //const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          authProvider.isAuthenticated
              ? DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              icon: CircleAvatar(
                backgroundImage:
                NetworkImage('https://via.placeholder.com/150'),
              ),
              items: [
                DropdownMenuItem(
                  value: 'profile',
                  child: Text('Profile'),
                ),
                DropdownMenuItem(
                  value: 'bookings',
                  child: Text('Bookings'),
                ),
                DropdownMenuItem(
                  value: 'payments',
                  child: Text('Payments'),
                ),
                DropdownMenuItem(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  authProvider.logout();
                } else if (value == 'bookings') {
                  Navigator.pushNamed(context, '/booking');
                } else if (value == 'payments') {
                  Navigator.pushNamed(context, '/payment');
                } else if (value == 'profile') {
                  Navigator.pushNamed(context, '/profile');
                }
              },
            ),
          )
              : Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search hotels or rooms...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                final hotel = hotels[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(hotel['name']!),
                    subtitle: Text(hotel['location']!),
                    trailing: ElevatedButton(
                      onPressed: () {
                        if (!authProvider.isAuthenticated) {
                          Navigator.pushNamed(context, '/login');
                        } else {
                          Navigator.pushNamed(
                            context,
                            '/booking',
                            arguments: {'hotel': hotel},
                          );
                        }
                      },
                      child: Text('Book Room'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
