import 'package:flutter/material.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/models/story.dart';

class TitleBlock extends StatelessWidget {
  final Story? selectedStory;
  final Function(String text) speak;
  const TitleBlock({super.key, required this.selectedStory, required this.speak});

  @override
  Widget build(BuildContext context) {
    speak(selectedStory!.title);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        gradient: gamebtnGradient,
        color: Color(0xffF2F2F2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color:  Color.fromARGB(64, 0, 0, 0),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Text(selectedStory!.title, style: textMedium.copyWith(color: Colors.black, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),

    );
  }
}