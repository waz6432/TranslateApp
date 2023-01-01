import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final VoidCallback onPressed;
  final IconData icon;
  final String text;
  final double? iconSize;

  const CustomContainer({
    super.key,
    required this.height,
    required this.width,
    required this.color,
    required this.onPressed,
    required this.icon,
    required this.text,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(icon),
            iconSize: iconSize,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(text),
        ),
      ],
    );
  }
}
