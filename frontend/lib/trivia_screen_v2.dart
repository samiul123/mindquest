import 'package:flutter/material.dart';
import 'package:frontend/utils.dart';

class TriviaScreen extends StatefulWidget {
  const TriviaScreen

  ({super.key});

  @override
  State<StatefulWidget> createState() => _TriviaScreenState();
}


class _TriviaScreenState extends State<TriviaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[850],
        body: Center (
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Card(
                    color: CustomColor.lightgrey,
                    child: Center(
                      child: Text(
                      'Question',
                      style: TextStyle(color: Colors.white),
                      // fontSize: 24
                      )
                    )
                ),
                Card(
                  color: CustomColor.lightgrey,
                  child: Center(
                      child: Text(
                      'Answer1',
                      style: TextStyle(color: Colors.white),
                      // fontSize: 24
                      )
                  )
                ),
                Card(
                  color: CustomColor.lightgrey,
                  child: Center(
                      child: Text(
                      'Answer2',
                      style: TextStyle(color: Colors.white),
                      // fontSize: 24
                      )
                    )
                ),
                Card(
                  color: CustomColor.lightgrey,
                  child: Center(
                    child: Text(
                    'Answer3',
                    style: TextStyle(color: Colors.white),
                    // fontSize: 24
                    )
                  )
                ),
                Card(
                  color: CustomColor.lightgrey,
                  child: Center(
                    child: Text(
                    'Answer2',
                    style: TextStyle(color: Colors.white),
                    // fontSize: 24
                    )
                    )
                  ),
              InkWell(
                onTap: () {

                },
                child: Card(
                  color: const Color.fromRGBO(159, 119, 226, 1),
                  child: Center(
                    child: Text(
                      'Submit',
                       style: TextStyle(color: Colors.white, fontSize: 24),

                    )
                  )
                )
              )
            ]
          )
        )
    ));
    }
}