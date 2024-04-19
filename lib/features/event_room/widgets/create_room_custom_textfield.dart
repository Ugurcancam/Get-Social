import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.width,
    required this.height,
    required this.hintText,
    required this.controller,
  });

  final double width;
  final double height;
  final String hintText;
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
        child: TextFormField(
          cursorColor: Colors.grey,
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.name,
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
    );
  }
}
