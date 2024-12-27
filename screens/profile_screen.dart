import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state_management/user_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: userProvider.currentUser == null
          ? Center(child: Text('No user logged in'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${userProvider.currentUser!.name}'),
            Text('Email: ${userProvider.currentUser!.email}'),
          ],
        ),
      ),
    );
  }
}
