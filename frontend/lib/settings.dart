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

  @override
  Widget build(BuildContext context) {
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
                            "TEXT_1",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          )),
                      const SizedBox(height: 25),
                      Flexible(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                //selectedAnswer = 'A';
                                  globals.flipTheme();
                              });
                            },
                            child: Card(
                                color: Colors.grey,
                                child: Center(
                                    child: Text(
                                      globals.darkTheme.toString(),
                                      style: const TextStyle(color: Colors.white),
                                      // fontSize: 24
                                    ))),
                          )),
                      const SizedBox(height: 10),

                      Flexible(
                          flex: 2,
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
                          //InkWell(
                          //   onTap: () {
                          //     setState(() {
                          //       //
                          //     });
                          //   },
                          //   child: Card(
                          //       color: Colors.grey,
                          //       child: Center(
                          //           child: Text(
                          //             "TEXT_2",
                          //             style: const TextStyle(color: Colors.white),
                          //             // fontSize: 24
                          //           ))),
                          // )
                          ),
                      const SizedBox(height: 10),
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


                    ]))));
  }
}
