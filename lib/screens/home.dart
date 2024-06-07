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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/main.dart';
import 'package:texttales/models/player.dart';
import 'package:texttales/services/auth_service.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

  final TextEditingController _joinGameController = TextEditingController();
  final ToggleJoinGame toggleJoinGame = ref.watch(toggleJoinGameProvider);
  final Player player = ref.watch(playerProvider);


  void signInWithGoogle() async {
    showDialog(context: context, builder: (context){
      return const Center(
          child: SpinKitCircle(
            color: Colors.redAccent,
            size: 50.0,
          ),
        );
    });

    PlayerUpdation().addAuthUser(ref, playerProvider);
    Navigator.pop(context);
  }

  void signOut() async {
    PlayerUpdation().removeAuthUser(ref, playerProvider);
  }

  void joinGame(){
    ref.read(toggleJoinGameProvider.notifier).toggle();
    Fluttertoast.showToast(msg: 'toggling notifier');
    Navigator.pushNamed(context, '/auth', arguments: {'mode':'join'});
  }

  return Scaffold(
      backgroundColor: dark,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: player.name == '' ? 40 : 25),
                margin: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    Text("TextTales", style: textTalesStyle.copyWith(fontSize: 50)),
                    player.playerId != '' ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(player.photoURL, scale: 2,),
                        Text(player.name, style: textMedium.copyWith(fontSize: 15),),
                      ],
                    ) : Container(),
                  ],
                )
              ),
          
              
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
          
              toggleJoinGame.toggleVal ? 
              GestureDetector(
                onTap: (){
                  ref.read(toggleJoinGameProvider.notifier).toggle();
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
              ) :
          
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: TextField(
                            controller: _joinGameController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 4,

                            decoration: InputDecoration(
                              hintText: 'Enter room ID',
                              counterText: "",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: secondaryColor, width: 1)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: primaryColor, width: 1)
                              ),
                              hintStyle: textMedium.copyWith(color: Colors.grey, fontSize: 15)       
                            ),
                            style: textMedium.copyWith(fontSize: 15),
                        ),
                      ),
                    ),
                    IconButton(onPressed: joinGame, 
                    icon: const FaIcon(FontAwesomeIcons.play), color: secondaryColor, iconSize: 60,),
                  ],
                ),
              ),
                        
              player.playerId == '' ? GestureDetector(
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
              ) :

              GestureDetector(
                onTap: signOut,
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
                        Text("Sign out", style: textMedium.copyWith(fontSize: 20, color: Colors.black)),
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
      ),
    );
  }
}


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