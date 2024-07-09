import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscure;
  final TextInputType keyboardType;
  const CustomField(
      {super.key, required this.hintText, required this.controller,this.isObscure=false,this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      
      ),
      obscureText: isObscure,
      keyboardType: keyboardType,
      validator: (val) {
        if (val!.trim().isEmpty) {
          return 'Please enter $hintText';
        }
        return null;
      },
    );
  }
}
