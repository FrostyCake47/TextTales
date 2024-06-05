// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod/riverpod.dart';

import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/main.dart';
import 'package:texttales/services/auth_service.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

  TextEditingController _joinGameController = TextEditingController();
  final toggleJoinGame = ref.watch(toggleJoinGameProvider);

  void signInWithGoogle() async {
    showDialog(context: context, builder: (context){
        return const Center(
            child: SpinKitCircle(
              color: Colors.redAccent,
              size: 50.0,
            ),
          );
      });

      try{
        User? user = await AuthService().signInWithGoogle();
        String name = user!.displayName ?? '';
        ref.read(playerProvider.notifier).updateName(name);
        print(playerProvider.name);
      }
      catch(e){
        print(e);
      }
      Navigator.pop(context);
    }

    return Scaffold(
      backgroundColor: dark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40),
              margin: const EdgeInsets.symmetric(vertical: 40),
              child: Text("TextTales", style: textTalesStyle.copyWith(fontSize: 50))
            ),

            Text(playerProvider.name ?? '', style: textMedium,),
            
            
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/auth', arguments: {'mode':'create'});
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                margin: const EdgeInsets.symmetric(vertical: 10,  horizontal: 20),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(child: Text("Create Game", style: textMedium.copyWith(fontSize: 20))),
              ),
            ),

            //toggleGameJoin ? 
            GestureDetector(
              onTap: (){
                //Navigator.pushNamed(context, '/auth', arguments: {'mode':'join'});
                ref.read(toggleJoinGameProvider.notifier).toggle();
                Fluttertoast.showToast(msg: 'toggling notifier');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                margin: const EdgeInsets.symmetric(vertical: 10,  horizontal: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(child: Text("Join game", style: textMedium.copyWith(fontSize: 20))),
              ),
            ),

            /*Row(
              children: [
                TextField(
                    controller: _joinGameController,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      hintStyle: textMedium.copyWith(color: Colors.grey, fontSize: 15)
                    ),
                    style: textMedium.copyWith(fontSize: 15),
                ),
              ],
            ),*/
            




            GestureDetector(
              onTap: signInWithGoogle,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                    children: [
                      Text("Sign in", style: textMedium.copyWith(fontSize: 20, color: Colors.black)),
                      SizedBox(width: 10,),
                      Image.asset('assets/google.png', width: 20,)
                    ],
                  ),
                ),
              ),
            ),

            Text(toggleJoinGame.toString())
          ],
        ),
      ),
    );
  }
}


/*class ToggleJoinGame extends StateNotifier<bool>{
  ToggleJoinGame() : super(false);

  void toggle(){
    state != state;
  }
}*/

class ToggleJoinGame {
  final bool toggleVal;

  ToggleJoinGame(
    this.toggleVal,
  );

  ToggleJoinGame copyWith({
    bool? toggleVal,
  }) {
    return ToggleJoinGame(
      toggleVal ?? this.toggleVal,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'toggleVal': toggleVal,
    };
  }

  factory ToggleJoinGame.fromMap(Map<String, dynamic> map) {
    return ToggleJoinGame(
      map['toggleVal'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ToggleJoinGame.fromJson(String source) => ToggleJoinGame.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ToggleJoinGame(toggleVal: $toggleVal)';

  @override
  bool operator ==(covariant ToggleJoinGame other) {
    if (identical(this, other)) return true;
  
    return 
      other.toggleVal == toggleVal;
  }

  @override
  int get hashCode => toggleVal.hashCode;
}

class ToggleJoinGameNotifier extends StateNotifier<ToggleJoinGame>{
  ToggleJoinGameNotifier(super.state);

  void toggle(){
    state = state.copyWith(toggleVal: !state.toggleVal);
  }
}