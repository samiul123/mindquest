import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/common_layout.dart';
import 'package:frontend/globals.dart' as globals;
import 'package:frontend/utils.dart';
import 'package:http/http.dart' as http;

import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool loggingOut = false, cancelLogout = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> handleLogout(BuildContext context) async {
    String apiUrl = '${dotenv.env["BASE_URL"]}/trivia/submit';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final response = await http.post(Uri.parse(apiUrl),
        body: jsonEncode({
          'username': 'sa001',
        }),
        headers: headers);
    if (response.statusCode == 200) {
      setState(() {
        // Navigate back to the log in page
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      });
    } else {
      throw Exception('Failed to submit');
    }
  }

  void logoutConfirm(BuildContext context) {
    loggingOut = true;
    cancelLogout = false;
    Navigator.pop(context, 'OK');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void logoutCancel(BuildContext context) {
    loggingOut = false;
    cancelLogout = true;
    Navigator.pop(context, 'Cancel');
  }

  // Function to return an AlertDialog to get a confirmation to log out
  AlertDialog confirmLogout(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmation:', style: TextStyle(color: Colors.white)),
      content: const Text(
          'You are about to log out, are you sure? (someone write better text)',
          style: TextStyle(color: Colors.white)),
      backgroundColor: CustomColor.purple,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      actions: <Widget>[
        TextButton(
          onPressed: () => logoutCancel(context),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        TextButton(
          onPressed: () => logoutConfirm(context),
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    loggingOut = false;
    cancelLogout = false;
    // This gets the WIP (Work In Progress) Alert Dialogue from globals.dart
    AlertDialog workInProgressAlert = globals.getWIPAlert(context);

    return Scaffold(
        backgroundColor: (globals.darkTheme)
            ? globals.dark_background
            : globals.light_background,
        appBar: AppBar(
          backgroundColor: CustomColor.purple,
          title: const Text('MindQuest', style: TextStyle(color: Colors.white)),
          // leading: _buildLeadingIcon(),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                print("Home image clicked");
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CommonLayout()));
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.home,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Change Username:
                      Flexible(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    workInProgressAlert,
                              );
                            },
                            child: const Card(
                                color: CustomColor.lightgrey,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          "Change Username",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        )))),
                          )),
                      //Change Picture:
                      Flexible(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    workInProgressAlert,
                              );
                            },
                            child: const Card(
                                color: CustomColor.lightgrey,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          "Change Picture",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        )))),
                          )),
                      //Change Password:
                      Flexible(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    workInProgressAlert,
                              );
                            },
                            child: const Card(
                                color: CustomColor.lightgrey,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          "Change Password",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        )))),
                          )),
                      // const SizedBox(height: 10),
                      //Notifications switch card:
                      Flexible(
                        flex: 1,
                        child: Card(
                            color: CustomColor.lightgrey,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Notifications ",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20),
                                            textAlign: TextAlign.center,
                                          )
                                      ),
                                      Expanded(child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Switch(
                                          // This bool value toggles the switch.
                                          value: globals.notifications,
                                          activeColor: Colors.white,
                                          onChanged: (bool value) {
                                            // This is called when the user toggles the switch.
                                            setState(() {
                                              globals.notifications = value;
                                            });
                                          },
                                        ),
                                      ))
                                    ],
                                  )),
                            )),
                      ),
                      // const SizedBox(height: 10),
                      //Dark mode switch card:
                      Flexible(
                        flex: 1,
                        child: Card(
                            color: CustomColor.lightgrey,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Dark Mode",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20),
                                            textAlign: TextAlign.center,
                                          )
                                      ),
                                      Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Switch(
                                              // This bool value toggles the switch.
                                              value: globals.darkTheme,
                                              activeColor: Colors.white,
                                              onChanged: (bool value) {
                                                // This is called when the user toggles the switch.
                                                setState(() {
                                                  globals.darkTheme = value;
                                                });
                                              },
                                            ),
                                          )
                                      )
                                    ],
                                  )),
                            )),
                      ),
                      const SizedBox(height: 150),
                      //Log-out:
                      Flexible(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              // Handle log out (add confirm button?):
                              //handleLogout(context);
                              //Temporary:
                              // Navigate back to the log in page
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    confirmLogout(context),
                              );

                              loggingOut = false;
                              cancelLogout = false;
                            },
                            child: const Card(
                                color: CustomColor.purple,
                                child: Center(
                                    child: Text(
                                  "Log Out",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ))),
                          )),
                      const SizedBox(height: 150),
                      // Old dark mode switch:
                      // Flexible(
                      //   flex: 2,
                      //   child: Switch(
                      //     // This bool value toggles the switch.
                      //     value: globals.darkTheme,
                      //     activeColor: Colors.white,
                      //     onChanged: (bool value) {
                      //       // This is called when the user toggles the switch.
                      //       setState(() {
                      //         globals.darkTheme = value;
                      //       });
                      //     },
                      //   ),
                      //   //InkWell(
                      //   //   onTap: () {
                      //   //     setState(() {
                      //   //       //
                      //   //     });
                      //   //   },
                      //   //   child: Card(
                      //   //       color: Colors.grey,
                      //   //       child: Center(
                      //   //           child: Text(
                      //   //             "TEXT_2",
                      //   //             style: const TextStyle(color: Colors.white),
                      //   //             // fontSize: 24
                      //   //           ))),
                      //   // )
                      // ),
                      // const SizedBox(height: 10),
                    ]))));
  }
}
