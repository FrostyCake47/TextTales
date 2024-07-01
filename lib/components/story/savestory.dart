import 'package:flutter/material.dart';
import 'package:texttales/constants/colors.dart';

class SaveStory extends StatelessWidget {
  const SaveStory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 10,  horizontal: 10),
        decoration: BoxDecoration(
          gradient: savestorygamebtnGradient,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(Icons.cloud_upload),
          ),
          Text('Save Story', style: TextStyle(color: Colors.black),),
        ],
      )),
    );
  }
}