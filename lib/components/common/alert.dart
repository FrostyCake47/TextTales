import 'package:flutter/material.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';


void createAlert(BuildContext context, String content, Gradient gradient) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        content: IntrinsicHeight(
          child: Container(
            child: Column(
              children: [
                Text(content, style: textMedium.copyWith(color: dark),),
                TextButton(
                  onPressed: (){Navigator.pop(context);}, 
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.green,
                      boxShadow: const [
                        BoxShadow(
                          color:  Color.fromARGB(64, 0, 0, 0),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 6), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Text('OK', style: textMedium.copyWith(color: Colors.black),)
                  )
                )
              ],
            ),
          ),
        ),

      );
    },
  );
}
