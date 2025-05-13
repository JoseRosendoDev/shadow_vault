import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  final double iconSize;
  final EdgeInsets padding;
  final BoxConstraints constraints;
  final Color backgroundColor;

  const CustomIconButton({
    super.key,
    required this.icon,
    this.color = Colors.white,
    required this.onPressed,
    this.iconSize = 24.0,
    this.padding = const EdgeInsets.all(8.0),
    this.constraints = const BoxConstraints(),
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: iconSize),
      ),
    );
  }
}
