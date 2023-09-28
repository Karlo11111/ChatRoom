import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.buttonText, required this.ontap});

  final Function()? ontap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black,
        ),
        alignment: Alignment.center,
        height: 70,
        child: Text(buttonText, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
      ),
    );
  }
}