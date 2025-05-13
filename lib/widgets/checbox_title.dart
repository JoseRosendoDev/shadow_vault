import 'package:flutter/material.dart';

class ChecboxTitle extends StatelessWidget {
  final String title;
  final Function(bool?)? callback;
  final bool? value;

  const ChecboxTitle({
    super.key,
    this.callback,
    required this.title,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: CheckboxListTile(
          fillColor: WidgetStatePropertyAll(Colors.transparent),
          checkColor: Colors.black,
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          value: value,
          onChanged: callback),
    );
  }
}
