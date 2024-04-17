import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/secure_storage.dart';
import 'package:frontend/utils.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EventCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EventCardState();

  static Future<void> addEventToStream() async {
    await _EventCardState._addEventToStream();
  }
}

class _EventCardState extends State<EventCard> {
  final secureStorage = const FlutterSecureStorage();
  static final StreamController<List<dynamic>> _eventController =
      StreamController.broadcast();

  Stream<List<dynamic>> get _eventStream => _eventController.stream;

  static Future<List<dynamic>> _fetchEvent() async {
    String? accessToken = await SecureStorage().storage.read(key: 'accessToken');
    print("Access token: $accessToken");
    String apiUrl = '${dotenv.env["BASE_URL"]}/events/current-week';
    Map<String, String> headers = {'Authorization': '$accessToken'};
    final response = await http.get(Uri.parse(apiUrl), headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<void> _addEventToStream() async {
    await _fetchEvent().then((value) => _eventController.add(value));
  }

  @override
  void initState() {
    super.initState();
    _addEventToStream();
  }

  // @override
  // void dispose() {
  //   _eventController.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<List<dynamic>>(
        initialData: null,
        stream: _eventStream,
        builder: (context, snapshot) {
          print("events $snapshot");
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
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            // If there is data but it's empty, show the message
            return const Card(
                color: CustomColor.lightgrey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: ListTile(
                          title: Text('Events this week',
                              style: TextStyle(
                                  color: Colors.white)), // Header title
                        )),
                    Expanded(
                        flex: 9,
                        child: Center(
                          child: Text(
                            'There are no events for now',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ],
                ));
          } else {
            return Card(
              color: CustomColor.lightgrey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header ListTile
                  const ListTile(
                    title: Text('Events this week',
                        style: TextStyle(color: Colors.white)), // Header title
                  ),
                  // ListView.builder for events
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = snapshot.data?[index];
                        return Column(
                          children: [
                            ListTile(
                              title: Text(item['title']!,
                                  style: const TextStyle(color: Colors.white)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Start Time: ${DateFormat('MMM d, y h:mm a').format(DateTime.parse(item['startTime']))}',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  Text('Location: ${item['location']}',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                            if (index < snapshot.data!.length - 1)
                              const Divider(height: 0, indent: 5, endIndent: 5),
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
