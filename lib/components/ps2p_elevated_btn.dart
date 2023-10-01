import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const MyButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'PressStart2P',
          color: Colors.white,
        ),
      ),
    );
  }
}
