import 'package:chatapp/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // ignore: sort_child_properties_last
      child: Text(
        text,
        style: const TextStyle(color: Colors.black),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          // ignore: deprecated_member_use
          primary: tabColor,
          minimumSize: const Size(double.infinity, 50)),
    );
  }
}
