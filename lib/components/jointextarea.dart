import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';

class JoinTextArea extends StatelessWidget {
  final TextEditingController joinGameController;
  final String text;
  final Function joinGame;
  const JoinTextArea({super.key, required this.joinGameController, required this.joinGame, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: TextField(
                  controller: joinGameController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  onChanged: (text){
                    if(text.length == 4){
                      Future.delayed(Durations.long1);
                      joinGame(int.tryParse(joinGameController.text) ?? 0);
                    }
                  },

                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    isDense: true,
          
                    hintText: text,
                    counterText: "",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.white, width: 3)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black, width: 3)
                    ),
                    hintStyle: textMedium.copyWith(color: Colors.black, fontSize: 15)       
                  ),
                  style: textMedium.copyWith(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          //IconButton(onPressed: (){joinGame();}, 
          //icon: const FaIcon(FontAwesomeIcons.play), color: Colors.black, iconSize: 60,),
          
        ],
      ),
    );
  }
}