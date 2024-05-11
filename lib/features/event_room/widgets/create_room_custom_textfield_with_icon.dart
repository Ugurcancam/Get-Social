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
    return InkWell(
      onTap: onPressed,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(fontSize: 18),
          prefixIcon: IconButton(onPressed: onPressed, icon: Icon(icon)),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
