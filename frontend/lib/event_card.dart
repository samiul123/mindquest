import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/utils.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EventCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  late List<dynamic> events;

  Future<List<dynamic>> _fetchData() async {
    String apiUrl = '${dotenv.env["BASE_URL"]}/events/current-week';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      // setState(() {
      //   events = json.decode(response.body);
      // });
      events = json.decode(response.body);
      // print(events);
      return events;
    } else {
      throw Exception('Failed to load data');
    }
  }


  // @override
  // void initState() {
  //   super.initState();
  //   _fetchData();
  // }

  @override
  Widget build(BuildContext context) {
    print("Building event card");

    // TODO: implement build
    return FutureBuilder<List<dynamic>>(
          future: _fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show loading indicator while fetching data
              return const Card(
                color: CustomColor.lightgrey,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              // Handle error case
              return Card(
                color: CustomColor.lightgrey,
                child: Center(
                  child: Text('Error: ${snapshot.error}'),
                ),
              );
            } else {
              return Card(
                color: CustomColor.lightgrey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header ListTile
                    const ListTile(
                      title: Text('Events',
                          style:
                              TextStyle(color: Colors.white)), // Header title
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
                                    style:
                                        const TextStyle(color: Colors.white)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Start Time: ${DateFormat('h:mm a').format(DateTime.parse(item['startTime']))}',
                                        style: const TextStyle(
                                            color: Colors.white)),
                                    Text('Location: ${item['location']}',
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                              if (index < events.length - 1)
                                const Divider(
                                    height: 0, indent: 5, endIndent: 5),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          });
  }
}
