import 'package:flutter/material.dart';

class LoginOptionsWidget extends StatelessWidget {
  const LoginOptionsWidget({required this.path, super.key});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: Colors.grey[200],
      ),
      width: 65, // Container genişliği
      height: 65, // Container yüksekliği
      child: Center(
        child: Image.asset(path, height: 30),
      ),
    );
  }
}
