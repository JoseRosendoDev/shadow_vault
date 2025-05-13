import 'package:flutter/cupertino.dart';

class CustomCupertinoButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const CustomCupertinoButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 25.0),
      color: color,
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: CupertinoColors.white),
      ),
    );
  }
}
