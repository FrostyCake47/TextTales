import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  Future<dynamic> someFunction() async {
    await Future.delayed(Durations.extralong2);
    return 'weow';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,
      body: Container(
        decoration: const BoxDecoration(
          gradient: bgGradient,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('History', style: textMedium.copyWith(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700),),
                Text('Watch your previous games', style: textMedium,),

                FutureBuilder(future: someFunction(), 
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return Container();
                  }
                  else return SpinKitCircle(color: Colors.white, size: 50.0,);
                })
              ],
            ),
          ),
        ),
      )
    );
  }
}