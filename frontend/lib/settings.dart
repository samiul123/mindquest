import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/globals.dart' as globals;

// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/utils.dart';
// import 'package:http/http.dart' as http;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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



  @override
  Widget build(BuildContext context) {
    // This gets the WIP (Work In Progress) Alert Dialogue from globals.dart
    AlertDialog workInProgressAlert = globals.getWIPAlert(context);

    return Scaffold(
        backgroundColor: (globals.darkTheme) ? globals.dark_background : globals.light_background,
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Positioned(
                          top: 20,
                          child: Text(
                            "  TOP        TEXT",
                            style: TextStyle(
                                color: (globals.darkTheme) ? Colors.white : Colors.black,
                                fontSize: 16),
                          )),
                      const SizedBox(height: 25),
                      //Change Username:
                      Flexible(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => workInProgressAlert,
                              );
                            },
                            child: const Card(
                                color: Colors.grey,
                                child: Center(
                                    child: Text(
                                      "Change Username",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                ))),
                          )),
                      //Change Picture:
                      Flexible(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => workInProgressAlert,
                              );
                            },
                            child: const Card(
                                color: Colors.grey,
                                child: Center(
                                    child: Text(
                                  "Change Picture",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ))),
                          )),
                      //Change Password:
                      Flexible(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => workInProgressAlert,
                              );
                            },
                            child: const Card(
                                color: Colors.grey,
                                child: Center(
                                    child: Text(
                                  "Change Password",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ))),
                          )),
                      // const SizedBox(height: 10),
                      //Notifications switch card:
                      Flexible(
                        flex: 0,
                        child: Card(
                            color: Colors.grey,
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [
                                Switch(
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
                                const SizedBox(width: 25),
                                const Text("Notifications ",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                    textAlign: TextAlign.center,

                                ),
                              ],
                            ))),
                      ),
                      // const SizedBox(height: 10),
                      //Dark mode switch card:
                      Flexible(
                        flex: 0,
                        child: Card(
                            color: Colors.grey,
                            child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Switch(
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
                                    const SizedBox(width: 25),
                                    const Text("Dark mode ",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                      textAlign: TextAlign.center,

                                    ),
                                  ],
                                ))),
                      ),
                      const SizedBox(height: 150),
                      //Log-out:
                      Flexible(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => workInProgressAlert,
                              );
                            },
                            child: const Card(
                                color: CustomColor.purple,
                                child: Center(
                                    child: Text(
                                      "Log Out",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
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
                      /*
                      Flexible(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                //selectedAnswer = 'C';
                              });
                            },
                            child: Card(
                                color: Colors.grey,
                                child: Center(
                                    child: Text(
                                      "TEXT_3",
                                      style: const TextStyle(color: Colors.white),
                                      // fontSize: 24
                                    ))),
                          )),
                      const SizedBox(height: 10),
                      Flexible(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                //selectedAnswer = 'D';
                              });
                            },
                            child: Card(
                                color: Colors.grey,
                                child: Center(
                                    child: Text(
                                      "TEXT_4",
                                      style: const TextStyle(color: Colors.white),
                                      // fontSize: 24
                                    ))),
                          )),
                      const SizedBox(height: 40),
                      Expanded(
                          flex: 2,
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  //
                                });
                              },
                              child: const Card(
                                color: CustomColor.purple,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Text(
                                          'Next',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24),
                                        ),
                                        Spacer(),
                                        Icon(Icons.arrow_forward,
                                            color: Colors.white),
                                      ],
                                    ),
                                  ),
                                ),
                              )))
*/
                    ]))));
  }
}
