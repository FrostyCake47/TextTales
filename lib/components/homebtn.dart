import 'package:flutter/material.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';

class HomeBtn extends StatelessWidget {
  final String text;
  const HomeBtn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      margin: const EdgeInsets.symmetric(vertical: 10,  horizontal: 20),
      decoration: BoxDecoration(
        gradient: homebtnGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color:  Color.fromARGB(64, 0, 0, 0),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 6), // changes position of shadow
          ),
        ],
      ),
      child: Center(child: Text(text, style: textMedium.copyWith(fontSize: 20, color: Colors.black))),
    );
  }
}