import 'package:flutter/material.dart';

class Divider extends StatelessWidget {
  double? height;
  Divider({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: height ?? 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
      ),
    );
  }
}