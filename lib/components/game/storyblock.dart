import 'package:flutter/material.dart';
import 'package:texttales/constants/textstyles.dart';

class StoryBlock extends StatelessWidget {
  final String title = 'Redshire';
  final String content = 'In the heart of the tranquil countryside, where rolling hills met the horizon and the whispers of ancient forests echoed through the valleys, lay a hidden gem known as Redshire. This picturesque village, shrouded in a timeless charm, was a place where every cobblestone street and ivy-clad cottage told a story of its own.';
  const StoryBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Color(0xffD9D9D9),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: textMedium.copyWith(color: Colors.black, fontWeight: FontWeight.w600),),
          SizedBox(height: 10,),
          Text(content, style: textMedium.copyWith(color: Colors.black, fontSize: 16),)
        ],
      )
    );
  }
}