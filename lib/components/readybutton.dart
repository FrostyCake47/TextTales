import 'package:flutter/material.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';

class ReadyButton extends StatelessWidget {
  const ReadyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 45,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: configCardInnerGradient,
        
        boxShadow: const [
          BoxShadow(
            color:  Color.fromARGB(100, 0, 0, 0),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Center(child: Text('Ready', style: textMedium.copyWith(color: Colors.white),))
    );

  }
}