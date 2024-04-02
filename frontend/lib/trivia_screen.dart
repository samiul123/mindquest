// // ignore_for_file: file_names
//
// // import 'dart:html';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:getwidget/getwidget.dart';
//
// class triviaScreen extends StatefulWidget {
//   const triviaScreen({Key? key}) : super(key: key);
//
//   @override
//   State<triviaScreen> createState() => _triviaWidgetState();
// }
//
// class _triviaWidgetState extends State<triviaScreen> {
//   // AudioPlayer player = new AudioPlayer();
//   // AudioCache cache = new AudioCache();
//   bool start = true;
//
//   int answer0 = 0;
//   int answer1 = 0;
//   int answer2 = 0;
//   int answer3 = 0;
//   int answer4 = 0;
//
//   int correctAnswer = 0;
//   int answerChoice = -1;
//
//   String question = "What is the air speed velocity of an unladed swallow?";
//   List<int> answerNum =
//   List.generate(5, (index) => (index == 0) ? index = 1 : (index += 1));
//
//   // Place holder answers
//   List<String> answers = [
//     "42",
//     "I don't know that",
//     "African or European swallow?",
//     "aaaaaaaa",
//     "124,000 mm/sec"
//   ];
//
//   int score = 0;
//
//   //region sounds
//   // void playMusic() async {
//   //   player = await cache.loop("fishing.mp3");
//   // }
//   //
//   // void gameOver() async {
//   //   player = await cache.play("gameover.wav");
//   // }
//   //
//   // void correctSF() async {
//   //   player = await cache.play("correct.mp3");
//   // }
//   //endregion
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   void nextQuestion() {
//     // if (questioner.hasAnswered) {
//     //   if (prefs.survivalMode || questioner.currentQuestion < prefs.numQs - 1) {
//     //     _restartTimer();
//     //     setState(() {
//     //       questioner.currentQuestion++;
//     //       questioner.hasAnswered = false;
//     //       answer0 = questioner
//     //           .gameQuestions[questioner.currentQuestion].yearAnswers[0];
//     //       answer1 = questioner
//     //           .gameQuestions[questioner.currentQuestion].yearAnswers[1];
//     //       answer2 = questioner
//     //           .gameQuestions[questioner.currentQuestion].yearAnswers[2];
//     //       answer3 = questioner
//     //           .gameQuestions[questioner.currentQuestion].yearAnswers[3];
//     //       answer4 = questioner
//     //           .gameQuestions[questioner.currentQuestion].yearAnswers[4];
//     //     });
//     //   } else {
//     //     player.stop();
//     //     cache.clearAll();
//     //     //music somehow still plays after this???
//     //     Navigator.pushReplacement(
//     //         context,
//     //         MaterialPageRoute(
//     //             builder: (context) => ResultScreenWidget(score, prefs.numQs)));
//     //   }
//     // }
//   }
//
//   Widget _buildCorrectDialog(BuildContext context) {
//     //var cur = questioner.gameQuestions[questioner.currentQuestion];
//     return Scaffold(
//         body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           GFAlert(
//             title: "Correct!",
//             titleTextStyle: TextStyle(fontSize: 40, color: Colors.white),
//             content: "questionText",
//             contentTextStyle: TextStyle(fontSize: 25, color: Colors.white),
//             type: GFAlertType.rounded,
//             backgroundColor: Colors.green,
//             bottombar: Row(children: [
//               Expanded(
//                   child: Padding(
//                       padding: EdgeInsets.only(right: 20),
//                       child: GFButton(
//                         text: "Main Menu",
//                         textStyle: TextStyle(fontSize: 20),
//                         size: 50,
//                         onPressed: () {
//                           Navigator.pop(context);
//                           Navigator.pop(context);
//                         },
//                       ))),
//               Expanded(
//                   child: Padding(
//                       padding: EdgeInsets.only(left: 10),
//                       child: GFButton(
//                         text: (0 <
//                             1) //(questioner.currentQuestion < prefs.numQs - 1)
//                             ? "Next Question"
//                             : "See Results",
//                         textStyle: TextStyle(fontSize: 20),
//                         size: 50,
//                         // icon: Icon(Icons.arrow_forward),
//                         onPressed: () {
//                           Navigator.pop(context);
//                           nextQuestion();
//                         },
//                       ))),
//             ]),
//           )
//         ]));
//   }
//
//   Widget _buildIncorrectDialog(BuildContext context) {
//     //var cur = gameQuestions[currentQuestion];
//     return Scaffold(
//         body: Column(mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//             GFAlert(
//             title: "Incorrect!",
//             titleTextStyle: TextStyle(fontSize: 40, color: Colors.white),
//             content: "question text",
//             //"${cur.questionText}\n\n${cur.correctYear}\n",
//             contentTextStyle: TextStyle(fontSize: 25, color: Colors.white),
//             type: GFAlertType.rounded,
//             backgroundColor: Colors.red,
//             bottombar: Row(children: [
//             Expanded(
//             child: Padding(
//             padding: EdgeInsets.only(right: 20),
//             child: GFButton(
//               text: "Main Menu",
//               textStyle: TextStyle(fontSize: 20),
//               size: 50,
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ))),
//   ]),
//   )
//   ]));
// }
//
//   Widget _buildTimeoutDialog(BuildContext context) {
//     //var cur = gameQuestions[currentQuestion];
//     return Scaffold(
//         body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           GFAlert(
//             title: "Out Of Time!",
//             titleTextStyle: TextStyle(fontSize: 40, color: Colors.white),
//             // content: "${cur.questionText}\n\n${cur.correctYear}\n",
//             // contentTextStyle: TextStyle(fontSize: 25, color: Colors.white),
//             type: GFAlertType.rounded,
//             backgroundColor: Colors.red,
//             bottombar: Row(children: [
//               Expanded(
//                   child: Padding(
//                       padding: EdgeInsets.only(right: 20),
//                       child: GFButton(
//                         text: "Main Menu",
//                         textStyle: TextStyle(fontSize: 20),
//                         size: 50,
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ))),
//             ]),
//           )
//         ]));
//   }
//
//   void correctAns() {
//     // int cur = questioner.gameQuestions[questioner.currentQuestion].correctYear;
//     // correctSF();
//     // popUpDialogue(context, "CORRECT", "You answered: $cur");
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => _buildCorrectDialog(context),
//     );
//     //_timer.cancel();
//     score += 1;
//   }
//
//   void wrongAns() {
//     //int cur = questioner.gameQuestions[questioner.currentQuestion].correctYear;
//     //gameOver();
//     // popUpDialogue(context, "FALSE", "The correct answer was: $cur");
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => _buildIncorrectDialog(context),
//     );
//     //_timer.cancel();
//   }
//
//   void changeAnswer(int c){
//     answerChoice = c;
//   }
//
//   void _submit(){
//     if (answerChoice == correctAnswer){
//       correctAns();
//     } else {
//       wrongAns();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // if (_counter == 0) {
//     //   timeOut();
//     // }
//     answer0 = 0;    //questioner.gameQuestions[questioner.currentQuestion].yearAnswers[0];
//     answer1 = 1;    //questioner.gameQuestions[questioner.currentQuestion].yearAnswers[1];
//     answer2 = 2;    //questioner.gameQuestions[questioner.currentQuestion].yearAnswers[2];
//     answer3 = 3;    //questioner.gameQuestions[questioner.currentQuestion].yearAnswers[3];
//     answer4 = 4;    //questioner.gameQuestions[questioner.currentQuestion].yearAnswers[4];
//
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//           title: const Text("Quiz!"),
//           backgroundColor: const Color.fromRGBO(159, 119, 226, 1),
//           foregroundColor: Colors.white,
//           /*leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           )*/
//       ),
//       backgroundColor: Colors.grey[850],
//       body: SingleChildScrollView(
//           child: Center(
//             widthFactor: 4,
//             child: Column(children: <Widget>[
//               const Padding(padding: EdgeInsets.all(20)),
//               const Padding(
//                 padding: EdgeInsets.only(
//                     left: 0, top: 20.0, right: 0, bottom: 20.0),
//                 child: Center(
//                     widthFactor: 4,
//                     heightFactor: 2,
//                     child: Text(
//                       "QUESTION:",
//                       style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(159, 119, 226, 1)),
//                       textAlign: TextAlign.center,
//                       textScaleFactor: 2,
//                     )
//                 ),
//               ), //Question
//               const Padding(
//                 padding: EdgeInsets.only(bottom: 20.0),
//               ), //IGNORE
//               // const Padding(
//               //   padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
//               // ), //IGNORE //Counter
//               GFButton(
//                 size: GFSize.LARGE,
//                 color: const Color.fromRGBO(177, 177, 177, 1),
//                 highlightColor: const Color.fromRGBO(159, 119, 226, 1),
//                 text: answers[0],
//                 onPressed: () {
//                   //int x = questioner.submitAnswer(questioner.gameQuestions[questioner.currentQuestion].yearAnswers[0]);
//                   //Change answer
//                   changeAnswer(0);
//                 },
//               ), //Ans0
//               GFButton(
//                 size: GFSize.LARGE,
//                 color: const Color.fromRGBO(177, 177, 177, 1),
//                 highlightColor: const Color.fromRGBO(159, 119, 226, 1),
//                 text: answers[1],
//                 onPressed: () {
//                   //int x = questioner.submitAnswer(questioner.gameQuestions[questioner.currentQuestion].yearAnswers[1]);
//
//                   //Change answer
//                   changeAnswer(1);
//                 },
//               ), //Ans1
//               GFButton(
//                 size: GFSize.LARGE,
//                 color: const Color.fromRGBO(177, 177, 177, 1),
//                 highlightColor: const Color.fromRGBO(159, 119, 226, 1),
//                 text: answers[2],
//                 onPressed: () {
//                   //Check if answer is correct
//                   //int x = questioner.submitAnswer(questioner.gameQuestions[questioner.currentQuestion].yearAnswers[2]);
//
//                   //Change answer
//                   changeAnswer(2);
//                 },
//               ), //Ans2
//               GFButton(
//                 size: GFSize.LARGE,
//                 color: const Color.fromRGBO(177, 177, 177, 1),
//                 highlightColor: const Color.fromRGBO(159, 119, 226, 1),
//                 text: answers[3],
//                 onPressed: () {
//                   //Check if answer is correct
//                   //int x = questioner.submitAnswer(questioner.gameQuestions[questioner.currentQuestion].yearAnswers[3]);
//
//                   //Change answer
//                   changeAnswer(3);
//                 },
//               ), //Ans3
//               GFButton(
//                 size: GFSize.LARGE,
//                 color: const Color.fromRGBO(177, 177, 177, 1),
//                 highlightColor: const Color.fromRGBO(159, 119, 226, 1),
//                 text: answers[4],
//                 onPressed: () {
//                   //Check if answer is correct
//                   //int x = questioner.submitAnswer(questioner.gameQuestions[questioner.currentQuestion].yearAnswers[4]);
//
//                   //Change answer
//                   changeAnswer(4);
//                 },
//               ), //Ans4
//               GFButton(
//                 size: GFSize.LARGE,
//                 color: const Color.fromRGBO(159, 119, 226, 1),
//                 text: "Submit Answer",
//                 onPressed: () {
//                   //Run submit function
//                   _submit();
//                 }), //Submit
//               // GFButton(
//               //     color: AdaptiveTheme.of(context).theme.primaryColorDark,
//               //     text: "Next Question",
//               //     onPressed: () {
//               //       //restart
//               //       nextQuestion();
//               //     }),
//               // GFButton(
//               //     color: Colors.red,
//               //     text: "QUIT",
//               //     onPressed: () {
//               //       //quit
//               //       player.stop();
//               //       Navigator.pop(context);
//               //     })
//
//             ]),
//           )),
//     );
//   }
//
// }
