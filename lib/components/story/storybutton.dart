import 'package:flutter/material.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';

class StoryButton extends StatelessWidget {
  const StoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15),
      margin: EdgeInsets.symmetric(vertical: 10,  horizontal: 30),
      decoration: BoxDecoration(
        gradient: homebtnGradient,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color:  Color.fromARGB(64, 0, 0, 0),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 6), // changes position of shadow
          ),
        ],
      ),
      child: Center(child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Image.network(''),
          //const SizedBox(width: 20,),
          Text('story1', style: textMedium.copyWith(fontSize: 20, color: Colors.black)),
        ],
      )),
    );
  }
}