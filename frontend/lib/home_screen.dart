import 'package:flutter/material.dart';
import 'package:frontend/event_card.dart';
import 'package:frontend/line_chart_widget.dart';
import 'package:frontend/trivia_score.dart';
import 'package:frontend/utils.dart';

import 'common_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool draw = false;
  static const events = [
    {"title": "event1", "time": "02-12-2023", "location": "Heller Hall 330"},
    {"title": "event2", "time": "02-12-2023", "location": "Heller Hall 330"}
  ];

  static List<TriviaScore> scores = [
    TriviaScore(Date.parseDate('12/01/2023'), 4),
    TriviaScore(Date.parseDate('12/02/2023'), 4),
    TriviaScore(Date.parseDate('12/03/2023'), 3),
  ];

  Future<void> onRefresh() async {
    print("On refresh");
    setState(() {
      draw = !draw;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Building home screen");
    return RefreshIndicator(
        onRefresh: onRefresh,
        child: CommonLayout(
          body: Column(
            children: [
              Expanded(
                flex: 4, // 40% of the screen height
                child: Card(
                  color: CustomColor.lightgrey,
                  child: Column(children: [
                    const Expanded(
                        flex: 1,
                        child: ListTile(
                            title: Text('Your scores',
                                style: TextStyle(color: Colors.white)))),
                    Expanded(flex: 9, child: LineChartWidget(scores: scores))
                  ]),
                ),
              ),
              Expanded(
                  flex: 4, // 40% of the screen height
                  child: EventCard()),
              Expanded(
                  flex: 2, // 20% of the screen height
                  child: InkWell(
                    onTap: () {
                      // Handle tap on the third card
                      print("Play trivia clicked");
                    },
                    child: const Card(
                      color: CustomColor.purple,
                      child: Center(
                        child: Text(
                          'Play Trivia',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }
}
