import 'package:flutter/material.dart';

class DectorButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const DectorButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontFamily: 'PressStart2P', fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
