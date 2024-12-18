import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final Color color;
  final Color backgroundColor;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
    this.color = Colors.white,
    this.backgroundColor = Colors.black,
}) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16)
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 20, color: color),
    ),
    onPressed: onClicked,
  );
}