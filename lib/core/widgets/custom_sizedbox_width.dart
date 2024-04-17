import 'package:flutter/material.dart';

class WidthBox extends StatelessWidget {
  const WidthBox({
    required this.width,
    super.key,
  });
  final double width;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
      );
}
