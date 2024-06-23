import 'package:flutter/material.dart';

class InputBlock extends StatelessWidget {
  const InputBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
        maxLines: null,
        maxLength: 10,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter your story here...',
          hintStyle: TextStyle()
        ),
        style: TextStyle(
          // You can add styling here if needed
        ),
      )
    );
  }
}