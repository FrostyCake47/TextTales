import 'package:flutter/material.dart';
import 'package:texttales/models/gamedata.dart';

class TitleBlock extends StatelessWidget {
  const TitleBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      decoration: BoxDecoration(
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
      child: const TextField(
        keyboardType: TextInputType.multiline,
        textAlign: TextAlign.center,
        
        maxLines: null,
        //maxLength: 10,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter your title',
          hintTextDirection: TextDirection.rtl,
          hintStyle: TextStyle(
            
          )

        ),
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18
        ),
      )
    );
  }
}