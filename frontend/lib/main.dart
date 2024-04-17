import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/breathing.dart';
import 'package:frontend/common_layout.dart';
import 'package:frontend/home_screen.dart';
import 'package:frontend/login_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/secure_storage.dart';
import 'package:http/http.dart' as http;


Future main() async {
  SecureStorage();
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> validateToken(String token) async {
    String apiUrl = '${dotenv.env["BASE_URL"]}/validate-token';
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': token};

    try {
      final response = await http.post(Uri.parse(apiUrl), headers: headers);
      return response.statusCode == 200;
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
    return false;
  }

  Future<Widget> getInitialScreen() async {
    String? accessToken = await SecureStorage().storage.read(key: 'accessToken');
    if (accessToken == null || await validateToken(accessToken) == false) {
      return const LoginScreen();
    }
    return const CommonLayout();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: getInitialScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Text('Error occurred');
        } else {
          return MaterialApp(
            title: 'MindQuest',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: snapshot.data!,
          );
        }
      },
    );
  }
}
