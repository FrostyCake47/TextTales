import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';

class HistoryBlock extends StatelessWidget {
  final WidgetRef ref;
  final Map<String, dynamic> game;
  final void Function(String gameId) pushToStory;
  const HistoryBlock({super.key, required this.game, required this.ref, required this.pushToStory});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10),
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
      child: GestureDetector(
        onTap: (){
          pushToStory(game['gameId'] ?? '');
        },
        child: Column(
          children: [
            Text(game['gameId'] ?? '', style: textMedium.copyWith(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 14),),
            ListView.builder(
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: game['titles'].length ?? 0,
              itemBuilder: (context, index){
                return Text(game['titles'][index], style: textMedium.copyWith(color: Colors.black, fontSize: 16), textAlign: TextAlign.center,);
              })
          ],
        ),
      ),
    );
  }
}