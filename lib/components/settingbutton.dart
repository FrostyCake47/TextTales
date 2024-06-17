import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:texttales/constants/textstyles.dart';

class SettingButton extends StatelessWidget {
  final String text;
  final String imgSrc;
  const SettingButton({super.key, required this.text, required this.imgSrc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15),
      margin: EdgeInsets.symmetric(vertical: 10,  horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
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
          SvgPicture.asset(
            'assets/$imgSrc.svg',
            width: 25,
            semanticsLabel: 'A red up arrow'
          ),
          const SizedBox(width: 20,),
          Text(text, style: textMedium.copyWith(fontSize: 20, color: Colors.black)),
        ],
      )),
    );
  }
}