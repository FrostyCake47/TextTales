import 'package:flutter/material.dart';

Future<bool> exitWarningDialogue(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to go back? Unsaved changes might be lost.', style: TextStyle(color: Colors.black),),
            actions: <Widget>[
              TextButton(
                onPressed: (){ Navigator.pop(context, false);},
                child: Text('No'),
              ),
              TextButton(
                onPressed: (){ Navigator.pop(context, true);},
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }