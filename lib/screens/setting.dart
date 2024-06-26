import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:texttales/components/settings/settingbutton.dart';
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
                    showDialog(context: context, builder: (BuildContext context){
                      TextEditingController controller = TextEditingController();
                      var box = Hive.box('serverip');
                      var name = box.get('ip');

                      return AlertDialog(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        title: Text('Current server: ${name ?? 'No server selected'}', style: textMedium.copyWith(fontSize: 16, color: Colors.black,), textAlign: TextAlign.center,),
                        content: IntrinsicHeight(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Choose new server', style: textMedium.copyWith(fontSize: 14, color: Colors.black)),
                              TextField(
                                controller: controller,
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Submit'),
                            onPressed: () {
                              box.put('ip', controller.text);
                              controller.clear();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
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