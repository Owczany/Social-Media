import 'package:flutter/material.dart';

// my first text field option
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration( 
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary, 
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        fillColor: Theme.of(context).colorScheme.primary, 
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle( // to change
          color: Colors.grey[500],
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------------- */
