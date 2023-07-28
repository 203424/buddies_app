import 'package:flutter/material.dart';

class ButtonFormWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? height;
  final double? width;

  const ButtonFormWidget(
      {super.key,
      required this.onPressed,
      required this.text,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 55.0,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  10.0), // Establece el radio de las esquinas
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
        ),
      ),
    );
  }
}
