import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key, 
    required this.hintText,
    required this.controller,
    required this.obscureText,
  });

  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(10, 100, 100, 100),
        borderRadius: BorderRadius.circular(10),
      ),
      child:  TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(horizontal: 20)),
      ),
    );
  }
}
