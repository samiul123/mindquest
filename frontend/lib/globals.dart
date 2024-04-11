library project.globals;
import 'package:flutter/material.dart';


bool darkTheme = true;

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
