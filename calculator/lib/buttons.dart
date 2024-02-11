import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final color;
  final textColor;
  final text;
  final buttonPressed;

  Button({this.color, this.textColor, this.text, this.buttonPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          color: color,
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: textColor, fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}
