// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod/riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:texttales/components/homebtn.dart';
import 'package:texttales/components/jointextarea.dart';
import 'package:texttales/components/loginbtn.dart';

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
      body: Container(
        decoration: const BoxDecoration(
          gradient: bgGradient,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: player.name == '' ? 40 : 25),
                  margin: const EdgeInsets.symmetric(vertical: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("TextTales", style: textTalesStyle.copyWith(fontSize: 50)),
                      SizedBox(height: 30,),
                      Text("Welcome to TextTales", style: textMedium.copyWith(fontSize: 25, fontWeight: FontWeight.bold),),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text("Join a game to continue an adventure or create your own story and invite friends to join.", textAlign: TextAlign.center,
                          style: textMedium.copyWith(fontSize: 20, fontWeight: FontWeight.w400),),
                      ),

                      player.playerId != '' ? IntrinsicWidth(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color.fromARGB(20, 217, 217, 217),
                            border: Border.all(color: Colors.black)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(player.photoURL, scale: 3,)
                              ),
                              const SizedBox(width: 10,),
                              Text(player.name, style: textMedium.copyWith(fontSize: 15),),
                              const SizedBox(width: 10,),
                              GestureDetector(
                                onTap: signOut,
                                child: SvgPicture.asset(
                                  'assets/signout.svg',
                                  width: 25,
                                  semanticsLabel: 'A red up arrow'
                                ),
                              ),
                            ],
                          ),
                        ),
                      ) : Container(),
                    ],
                  )
                ),

            
                
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/auth', arguments: {'mode':'create'});
                  },
                  child: HomeBtn(text: 'Create Game', imgSrc: 'create',)
                ),
            

                toggleJoinGame.toggleVal ? 
                GestureDetector(
                  onTap: (){
                    ref.read(toggleJoinGameProvider.notifier).toggle();
                  },
                  child: HomeBtn(text: "Join Game", imgSrc: 'join',),
                ) : JoinTextArea(joinGameController: _joinGameController, joinGame: joinGame, text: "Enter room ID"),

                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/auth', arguments: {'mode':'create'});
                  },
                  child: HomeBtn(text: 'Setting',imgSrc: 'setting', px: 8, mx: 80,)
                ),
                const SizedBox(
                  height: 20,
                ),

                player.playerId == '' ? 
                Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      ),
                      Text("Login if you haven't", style: textMedium.copyWith(color: Colors.black, fontSize: 15),),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: signInWithGoogle,
                          child: IntrinsicWidth(child: LoginBtn(imgSrc: 'google')),
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: IntrinsicWidth(child: LoginBtn(imgSrc: 'apple')),
                        )
                      ],
                    ),
                  ),
                ],)
                : Container(),

                Text(toggleJoinGame.toString())
              ],
            ),
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