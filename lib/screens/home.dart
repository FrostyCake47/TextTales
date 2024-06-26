// ignore_for_file: public_member_api_docs, sort_constructors_first, curly_braces_in_flow_control_structures, use_build_context_synchronously
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
import 'package:texttales/components/home/homebtn.dart';
import 'package:texttales/components/home/jointextarea.dart';
import 'package:texttales/components/home/loginbtn.dart';

import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/main.dart';
import 'package:texttales/models/lobbystatus.dart';
import 'package:texttales/models/player.dart';
import 'package:texttales/components/common/alert.dart';
import 'package:texttales/services/auth_service.dart';
import 'package:texttales/services/gamerequest.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({super.key});

  bool isPlayerInitiallyUpdated = false;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {

  final TextEditingController _joinGameController = TextEditingController();
  final ToggleJoinGame toggleJoinGame = ref.watch(toggleJoinGameProvider);
  final Player player = ref.watch(playerProvider);


  @override 
  void dispose(){
    _joinGameController.dispose();
    super.dispose();
  }

  User? _user = FirebaseAuth.instance.currentUser;
  if(!widget.isPlayerInitiallyUpdated && _user != null){
    String name = _user!.displayName ?? '';
    String photoURL = _user.photoURL ?? '';
    String playerId = _user.uid ?? '';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.isPlayerInitiallyUpdated = true;
      ref.read(playerProvider.notifier).updateAll(playerId, photoURL, name);
      ref.read(lobbyStatusProvider.notifier).clearAll();
      //ref.read(gameDataProvider.notifier).clearAll();
    });
    //huh
    
  }

  void signInWithGoogle() async {
    showDialog(context: context, builder: (context){
      return const Center(
          child: SpinKitCircle(
            color: Colors.white,
            size: 50.0,
          ),
        );
    });

    try{
      await PlayerUpdation().addAuthUser(ref, playerProvider);
    }
    catch(e){
      print("Auth error :${e.toString()}");
      createAlert(context, "Auth Error: Try logging again", homebtnGradient);
    }
    finally{
      Navigator.pop(context);
    }
    
  }

  void signOut() async {
    PlayerUpdation().removeAuthUser(ref, playerProvider);
  }

  bool isPlayerAuth(){
    return _user == null ? false : true;
  }

  void joinGame(int roomId) async {
    ref.read(toggleJoinGameProvider.notifier).toggle();
    if(isPlayerAuth()){
      int status =  await GameRequest().getRoomStatus(roomId, ref);
      print("status at home $status");
      if(status == 0) Navigator.pushNamed(context, '/auth', arguments: {'mode':'join', 'roomId':roomId, 'ref':ref});
      else if(status == 1) createAlert(context, "Invalid RoomId", homebtnGradient);
      else createAlert(context, "Server Error: Try again later", homebtnGradient);
    }
    else {
      Fluttertoast.showToast(msg: 'Login first');
    }
  }

  void createGame() async {
    showDialog(context: context, builder: (context){
      return const Center(
          child: SpinKitCircle(
            color: Colors.white,
            size: 50.0,
          ),
        );
    });

    print('PLauer auth ${isPlayerAuth()}');
    if(isPlayerAuth()){
      int roomId = await GameRequest().getRoomId(player, ref);
      print(roomId);
      Navigator.pop(context);

      if(roomId == 0) createAlert(context, "Couldn't allocate you a room: Try again later", homebtnGradient);
      else if(roomId == -1) createAlert(context, "Server Error: Try again later", homebtnGradient);
      else Navigator.pushNamed(context, '/auth', arguments: {'mode':'create', 'roomId':roomId});
    }
    else {
      Navigator.pop(context);
      createAlert(context, 'Login and try again', homebtnGradient);
    }
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
                  onTap: createGame,
                  child: HomeBtn(text: 'Create Game', imgSrc: 'create',)
                ),
            

                toggleJoinGame.toggleVal ? 
                GestureDetector(
                  onTap: (){
                    ref.read(toggleJoinGameProvider.notifier).toggle();
                  },
                  child: HomeBtn(text: "Join Game", imgSrc: 'join',),
                ) : JoinTextArea(joinGameController: _joinGameController, joinGame: joinGame, text: "Enter room ID"),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/setting',);
                        },
                        child: HomeBtn(text: 'Setting',imgSrc: 'setting', px: 8, mr:10)
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/history',);
                        },
                        child: HomeBtn(text: 'History',imgSrc: 'history', px: 8, ml:10,)
                      ),
                    ),
                  ],
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

                //Text(toggleJoinGame.toString())
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