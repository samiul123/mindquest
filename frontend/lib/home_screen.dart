import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/event_card.dart';
import 'package:frontend/line_chart_widget.dart';
import 'package:frontend/trivia_score.dart';
import 'package:frontend/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> onRefresh() async {
    EventCard.addEventToStream();
    LineChartWidget.addScoreToStream();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: onRefresh,
        child: Column(
          children: [
            Expanded(
              flex: 4, // 40% of the screen height
              child: LineChartWidget(),
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
        ));
  }
}
