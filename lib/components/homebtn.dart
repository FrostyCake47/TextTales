import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';

class HomeBtn extends StatelessWidget {
  final String text;
  final String imgSrc;
  double? px;
  double? mx;
  HomeBtn({super.key, required this.text, this.px, this.mx, required this.imgSrc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: px ?? 15),
      margin: EdgeInsets.symmetric(vertical: 10,  horizontal: mx ?? 30),
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