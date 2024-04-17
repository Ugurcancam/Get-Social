import 'package:flutter/material.dart';

class HeightBox extends StatelessWidget {
  const HeightBox({
    required this.height,
    super.key,
  });
  final double height;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
      );
}
