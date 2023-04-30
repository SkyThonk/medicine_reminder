import 'package:flutter/material.dart';

class TextFieldWithIconWidget extends StatelessWidget {
  const TextFieldWithIconWidget(
      {super.key,
      required this.controller,
      required this.hinttext,
      required this.iconData});
  final TextEditingController controller;
  final String hinttext;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(iconData),
        hintText: hinttext,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
