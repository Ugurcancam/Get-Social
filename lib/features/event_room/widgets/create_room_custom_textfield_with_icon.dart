import 'package:flutter/material.dart';

class CustomTextFieldWithIcon extends StatelessWidget {
  const CustomTextFieldWithIcon({
    super.key,
    required this.width,
    required this.height,
    required this.hintText,
    required this.controller,
    required this.icon,
    required this.onPressed,
  });

  final double width;
  final double height;
  final String hintText;
  final IconData icon;
  final VoidCallback onPressed;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromRGBO(49, 62, 85, 0.78),
      ),
      child: Center(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(left: 16),
                ),
              ),
            ),
            const Spacer(),
            Expanded(
              child: IconButton(
                onPressed: onPressed,
                icon: Icon(icon, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
