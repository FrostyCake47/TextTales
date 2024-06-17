import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texttales/components/settingbutton.dart';
import 'package:texttales/constants/textstyles.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Container(
        color: Colors.black12,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Text("Settings", style: textMedium.copyWith(fontSize: 32, fontWeight: FontWeight.bold), ),
                ),
                Text("Change your configurations here", style: textMedium.copyWith(fontSize: 16),),

                SizedBox(height: 40,),

                GestureDetector(
                  onTap: (){
                    showDialog(context: context, builder: (context){
                      return Scaffold(
                        body: Column(
                          children: [
                            Text("server 1"),
                          ],
                        ),
                      );
                    });
                  },
                  child: SettingButton(text: 'Select Server', imgSrc: 'signal'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}