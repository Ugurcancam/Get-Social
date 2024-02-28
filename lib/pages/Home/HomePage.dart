import 'package:etkinlikapp/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            AuthService().signOut(context);
          },
        ),
      ]),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
