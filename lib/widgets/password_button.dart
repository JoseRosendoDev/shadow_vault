import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const PasswordButton({
    super.key,
    required this.icon,
    this.color = Colors.black,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      sizeStyle: CupertinoButtonSize.medium,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
