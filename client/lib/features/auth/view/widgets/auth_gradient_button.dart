import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButtonn extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const AuthGradientButtonn(
      {super.key, required this.buttonText, required this.onPressed});

  @override
  State<AuthGradientButtonn> createState() => _AuthGradientButtonnState();
}

class _AuthGradientButtonnState extends State<AuthGradientButtonn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Pallete.gradient1, Pallete.gradient2],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Pallete.transparentColor,
          shadowColor: Pallete.transparentColor,
          fixedSize: Size(395, 55),
        ),
        child: Text(
          widget.buttonText,
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}
