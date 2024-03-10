import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'homescreen.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool showError = false;
  String errorMessage = "";

  Future<void> handleSignup() async {
    final String username = usernameController.text;
    final String password = passwordController.text;
    final String email = emailController.text;

    // Replace with your backend API URL
    const String apiUrl = 'http://192.168.1.240:8080/signup';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(Uri.parse(apiUrl),
          body: jsonEncode({
            'username': username,
            'password': password,
            'email': email
          }),
          headers: headers);
      if (!mounted) return;
      if (response.statusCode == 200) {
        // Successful sign up
        print('sign up successful');
        // Navigate to the home screen or perform other actions
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        // Failed login
        print('Sign up failed');
        // Show an error message or perform other actions
        setState(() {
          showError = true;
          errorMessage = response.body;
        });
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
      setState(() {
        showError = true;
        errorMessage = "Server is busy. Please try again later.";
      });
    }
  }

  // void handleLogin() {
  //   String username = usernameController.text;
  //   String password = passwordController.text;
  //
  //   // Simulate login logic (Replace with actual authentication logic)
  //   if (username == 'example' && password == 'password') {
  //     // Successful login
  //     print('Login successful');
  //     // Navigate to the home screen or perform other actions
  //   } else {
  //     // Failed login
  //     print('Login failed');
  //     // Show error message
  //     setState(() {
  //       showError = true;
  //     });
  //   }
  // }

  void closeError() {
    // Close the error message
    setState(() {
      showError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildLogo(),
              const SizedBox(height: 20),
              buildUsernameField(),
              const SizedBox(height: 10),
              buildEmailField(),
              const SizedBox(height: 10),
              buildPasswordField(),
              const SizedBox(height: 20),
              buildSignupButton(),
              const SizedBox(height: 20),
              // Display error message if showError is true
              if (showError)
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Close the error message
                          closeError();
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton buildSignupButton() {
    return ElevatedButton(
      onPressed: () {
        // Handle login logic
        handleSignup();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
      ),
      child: const Text('Sign up', style: TextStyle(color: Colors.white)),
    );
  }
  
  TextField buildPasswordField() {
    return TextField(
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }

  TextField buildUsernameField() {
    return TextField(
      controller: usernameController,
      decoration: const InputDecoration(
        hintText: 'Username',
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }

  TextField buildEmailField() {
    return TextField(
      controller: emailController,
      decoration: const InputDecoration(
        hintText: 'Email',
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }

  Row buildLogo() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'MIND',
          style: TextStyle(color: Colors.purple, fontSize: 24),
        ),
        Text(
          'QUEST',
          style: TextStyle(color: Colors.white, fontSize: 24),
        )
      ],
    );
  }
}
