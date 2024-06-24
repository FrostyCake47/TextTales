import 'package:flutter/material.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/models/lobbystatus.dart';

class SubmitButton extends StatelessWidget {
  final bool isSubmitted;
  const SubmitButton({super.key, required this.isSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 45,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: isSubmitted ? submittedButtonGradient : submitButtonGradient,
        
        boxShadow: const [
          BoxShadow(
            color:  Color.fromARGB(100, 0, 0, 0),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child:(Center(child: Text(isSubmitted ? "Submitted" : 'Submit', style: textMedium.copyWith(color: Colors.white),)))
      
        
    );

  }
}