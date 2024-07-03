import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/main.dart';
import 'package:texttales/models/player.dart';
import 'package:texttales/services/gamerequest.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  late dynamic history;

  Future<dynamic> handleFutureBuilder(String playerId) async {
    final _history = await GameRequest().getGameHistory(playerId);
    return _history;
  }

  @override
  Widget build(BuildContext context) {
    Player player = ref.watch(playerProvider);
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

                FutureBuilder(future: handleFutureBuilder(player.playerId), 
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return SpinKitCircle(color: Colors.white, size: 50.0,);
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); // Show error message
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No data found'); // Show message if no data is found
                  } else {
                   return Text(snapshot.data.toString());
                }})
              ],
            ),
          ),
        ),
      )
    );
  }
}