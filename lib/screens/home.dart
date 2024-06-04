import 'package:flutter/material.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String clientID = 'mwaa';

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
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

            Text(clientID, style: textMedium,),
            
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/auth', arguments: {'mode':'create'});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Text("Create Game", style: textMedium.copyWith(fontSize: 20)),
              ),
            ),

            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/auth', arguments: {'mode':'join'});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Text("Join game", style: textMedium.copyWith(fontSize: 20)),
              ),
            ),

            GestureDetector(
              onTap: () async {
                try{
                  print("login");
                }
                catch (e) {
                  print(e);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Text("Google Sign in", style: textMedium.copyWith(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


