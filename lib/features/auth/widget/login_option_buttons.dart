import 'package:flutter/material.dart';

class LoginOptionButton extends StatelessWidget {
  const LoginOptionButton({required this.imagePath, required this.loginOptionText, super.key, required this.path});
  final String imagePath;
  final String loginOptionText;
  final String path;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, path),
      child: Container(
        width: 320,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black54,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 8),
            Text(
              loginOptionText,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
