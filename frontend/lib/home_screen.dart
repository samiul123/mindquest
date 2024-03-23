import 'package:flutter/material.dart';
import 'package:frontend/utils.dart';

import 'common_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const events = [
    {"title": "event1", "time": "02-12-2023", "location": "Heller Hall 330"},
    {"title": "event2", "time": "02-12-2023", "location": "Heller Hall 330"}
  ];

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      body: Column(
        children: [
          const Expanded(
            flex: 4, // 80% of the screen height
            child: Card(
              color: CustomColor.lightgrey,
              child: ListTile(
                title: Text(
                  'Card 1',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4, // 80% of the screen height
            child: Card(
              color: CustomColor.lightgrey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header ListTile
                  const ListTile(
                    title: Text('Events',
                        style: TextStyle(color: Colors.white)), // Header title
                  ),
                  // ListView.builder for events
                  Expanded(
                    child: ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = events[index];
                        return Column(
                          children: [
                            ListTile(
                              title: Text(item['title']!,
                                  style: const TextStyle(color: Colors.white)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Time: ${item['time']}',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  Text('Location: ${item['location']}',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                            if (index < events.length - 1)
                              const Divider(height: 0, indent: 5, endIndent: 5),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
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
    );
  }
}
