import 'package:flutter/cupertino.dart';

class CustomCupertinoTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final Widget? suffix;

  const CustomCupertinoTextField({
    super.key,
    required this.controller,
    required this.placeholder,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CupertinoTextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        placeholder: placeholder,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: CupertinoColors.inactiveGray),
          borderRadius: BorderRadius.circular(8),
        ),
        suffix: suffix,
      ),
    );
  }
}
