import 'package:flutter/material.dart';

class PositionedCircle extends StatelessWidget {
  const PositionedCircle({
    super.key,
    required this.color,
    required this.iconData,
    required this.onPressed,
    this.top,
  });

  final Color color;
  final IconData iconData;
  final VoidCallback onPressed;
  final double? top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(iconData),
          iconSize: 40.0,
          color: Colors.white,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
