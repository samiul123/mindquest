import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/secure_storage.dart';
import 'package:frontend/utils.dart';
import 'package:http/http.dart' as http;
import 'globals.dart' as globals;

class TriviaScreen extends StatefulWidget {
  const TriviaScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TriviaScreenState();
}

class _TriviaScreenState extends State<TriviaScreen> {
  static final StreamController<List<dynamic>> _triviaController =
      StreamController.broadcast();

  Stream<List<dynamic>> get _triviaStream => _triviaController.stream;
  dynamic triviaData;
  late bool answerCorrect;
  late String selectedAnswer;
  late bool answerSubmitted;

  Future<void> _fetchAndSetTrivia() async {
    try {
      dynamic data = await _fetchTrivia();
      print(data);
      setState(() {
        triviaData = data;
      });
    } catch (e) {
      print('Error fetching trivia: $e');
    }
  }

  static Future<dynamic> _fetchTrivia() async {
    String? accessToken = await SecureStorage().storage.read(key: 'accessToken');
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': '$accessToken'};
    String apiUrl = '${dotenv.env["BASE_URL"]}/trivia/next';
    final response = await http.get(Uri.parse(apiUrl), headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> _handleSubmit() async {
    String? accessToken = await SecureStorage().storage.read(key: 'accessToken');
    String apiUrl = '${dotenv.env["BASE_URL"]}/trivia/submit';
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': '$accessToken'};
    final response = await http.post(Uri.parse(apiUrl),
        body: jsonEncode({
          'triviaId': triviaData['id'],
          'choice': selectedAnswer
        }),
        headers: headers);
    if (response.statusCode == 200) {
      setState(() {
        answerCorrect = response.body == 'true' ? true : false;
        answerSubmitted = true;
      });
    } else {
      throw Exception('Failed to submit');
    }
  }

  Color _setAnswerCardColor(String option) {
    if (answerSubmitted) {
      if (selectedAnswer == option) {
        if (answerCorrect == true) {
          return Colors.green;
        } else {
          return Colors.red;
        }
      } else {
        return CustomColor.lightgrey;
      }
    } else {
      if (selectedAnswer == option) {
        return CustomColor.purple;
      } else {
        return CustomColor.lightgrey;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchAndSetTrivia();
    answerSubmitted = false;
    selectedAnswer = '';
    answerCorrect = false;
  }

  @override
  Widget build(BuildContext context) {
    if (triviaData == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
        backgroundColor: (globals.darkTheme)
            ? globals.dark_background
            : globals.light_background,
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
                            triviaData['question'],
                            style: const TextStyle(
                                color: (!globals.darkTheme)
                                    ? globals.dark_background
                                    : globals.light_background, fontSize: 16),
                          )),
                      const SizedBox(height: 25),
                      Flexible(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedAnswer = 'A';
                              });
                            },
                            child: Card(
                                color: _setAnswerCardColor('A'),
                                child: Center(
                                    child: Text(
                                  triviaData['optionA'],
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
                                selectedAnswer = 'B';
                              });
                            },
                            child: Card(
                                color: _setAnswerCardColor('B'),
                                child: Center(
                                    child: Text(
                                  triviaData['optionB'],
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
                                selectedAnswer = 'C';
                              });
                            },
                            child: Card(
                                color: _setAnswerCardColor('C'),
                                child: Center(
                                    child: Text(
                                  triviaData['optionC'],
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
                                selectedAnswer = 'D';
                              });
                            },
                            child: Card(
                                color: _setAnswerCardColor('D'),
                                child: Center(
                                    child: Text(
                                  triviaData['optionD'],
                                  style: const TextStyle(color: Colors.white),
                                  // fontSize: 24
                                ))),
                          )),
                      const SizedBox(height: 40),
                      Expanded(
                          flex: 2,
                          child: InkWell(
                              onTap: () {
                                _handleSubmit();

                                Timer(const Duration(seconds: 3), () {
                                  setState(() {
                                    answerSubmitted = false;
                                    selectedAnswer = '';
                                    answerCorrect = false;
                                  });
                                  _fetchAndSetTrivia();
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
