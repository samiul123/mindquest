import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showError = false;

  void handleLogin() {
    String username = usernameController.text;
    String password = passwordController.text;

    // Simulate login logic (Replace with actual authentication logic)
    if (username == 'example' && password == 'password') {
      // Successful login
      print('Login successful');
      // Navigate to the home screen or perform other actions
    } else {
      // Failed login
      print('Login failed');
      // Show error message
      setState(() {
        showError = true;
      });
    }
  }

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
              buildPasswordField(),
              const SizedBox(height: 20),
              buildSignupPrompt(),
              const SizedBox(height: 20),
              buildLoginButton(),
              const SizedBox(height: 20),
              // Display error message if showError is true
              if (showError)
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Incorrect username or password!',
                        style: TextStyle(color: Colors.white),
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
                ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        // Handle login logic
        handleLogin();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
      ),
      child: const Text('Log In', style: TextStyle(color: Colors.white)),
    );
  }

  Row buildSignupPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.white),
        ),
        GestureDetector(
            onTap: () {
              //   TODO: Navigate to sign up page
            },
            child: const Text("Sign up", style: TextStyle(color: Colors.blue)))
      ],
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
