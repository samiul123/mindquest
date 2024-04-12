library project.globals;
import 'package:flutter/material.dart';
import 'package:frontend/utils.dart';

bool darkTheme = true;
bool notifications = false;

// Background colors
Color? dark_background = Colors.grey[850];
Color? light_background = Colors.grey[150];
// Foreground colors
Color? foreground = Colors.grey;
// Accent colors
Color? dark_accent = Colors.grey[900];
Color? light_accent = Colors.grey[250];
// Text colors
Color? dark_text = Colors.white;
Color? light_text = Colors.grey[150];


void flipTheme() { darkTheme = !darkTheme; }

// Function to return a standardized WIP (Work In Progress) Alert Dialogue
AlertDialog getWIPAlert(BuildContext context){
  return AlertDialog(
    title: const Text('In development!', style: TextStyle(color: Colors.white)),
    content: const Text('This feature is currently being developed, please be patient in the meantime.\nThank you!', style: TextStyle(color: Colors.white)),
    backgroundColor: CustomColor.purple,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
    actions: <Widget>[
      // TextButton(
      //   onPressed: () => Navigator.pop(context, 'Cancel'),
      //   child: const Text('Cancel'),
      // ),
      TextButton(
        onPressed: () => Navigator.pop(context, 'OK'),
        child: const Text('OK', style: TextStyle(color: Colors.white, fontSize: 20),),
      ),
    ],
  );
}