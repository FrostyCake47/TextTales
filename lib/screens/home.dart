import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/main.dart';
import 'package:texttales/services/auth_service.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

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

            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/auth', arguments: {'mode':'join'});
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
          ],
        ),
      ),
    );
  }
}


