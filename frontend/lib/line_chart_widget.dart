import 'dart:async';
import 'dart:convert';

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart' as FlutterTextStyle;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/secure_storage.dart';
import 'package:frontend/utils.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class LineChartWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LineChartWidgetState();

  static Future<void> addScoreToStream() async {
    await _LineChartWidgetState._addScoreToStream();
  }
}

class _LineChartWidgetState extends State<LineChartWidget> {
  static late List<dynamic> scores;
  static final StreamController<List<dynamic>> _lineChartController =
      StreamController.broadcast();

  Stream<List<dynamic>> get _lineChartStream => _lineChartController.stream;

  List<Series<dynamic, DateTime>> _createSampleData() {
    return [
      Series(
          id: 'Score',
          data: scores,
          domainFn: (dynamic score, _) => DateTime.parse(score['date']),
          measureFn: (dynamic score, _) => score['aggregatedScore'] as int)
    ];
  }

  static Future<List<dynamic>> _fetchData() async {
    //TODO: change username
    String apiUrl = '${dotenv.env["BASE_URL"]}/trivia/agg-score';
    Map<String, String> headers = {'Authorization': '${await SecureStorage().storage.read(key: 'accessToken')}'};
    final response = await http.get(Uri.parse(apiUrl), headers: headers);
    if (response.statusCode == 200) {
      // setState(() {
      //   events = json.decode(response.body);
      // });
      scores = json.decode(response.body);
      print("Scores: $scores");
      return scores;
      // print(events);
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<void> _addScoreToStream() async {
    await _fetchData().then((value) => _lineChartController.add(value));
  }

  @override
  void initState() {
    super.initState();
    _addScoreToStream();
  }

  // @override
  // void dispose() {
  //   _lineChartController.close();
  //   super.dispose();
  // }

  // // Calculate dynamic margins based on the content width
  // double calculateLeftMargin(double contentWidth) {
  //   // Your logic to calculate the left margin based on contentWidth
  //   return contentWidth * 0.1; // Example: 10% of content width
  // }
  //
  // double calculateRightMargin(double contentWidth) {
  //   // Your logic to calculate the right margin based on contentWidth
  //   return contentWidth * 0.1; // Example: 10% of content width
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<List<dynamic>>(
      initialData: null,
      stream: _lineChartStream,
      builder: (context, snapshot) {
        print(snapshot);
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                double cardWidth = constraints.maxWidth;
                double contentWidth = cardWidth - 5;

                return Column(children: [
                  const Expanded(
                      flex: 1,
                      child: ListTile(
                          title: Text('Your scores',
                              style: FlutterTextStyle.TextStyle(
                                  color: Colors.white)))),
                  Expanded(
                      flex: 9,
                      child: TimeSeriesChart(_createSampleData(),
                          // layoutConfig: LayoutConfig(
                          //   leftMarginSpec: MarginSpec.fixedPixel(calculateLeftMargin(contentWidth).toInt()),
                          //   rightMarginSpec: MarginSpec.fixedPixel(calculateRightMargin(contentWidth).toInt()),
                          //   topMarginSpec: MarginSpec.fixedPixel(20),
                          //   bottomMarginSpec: MarginSpec.fixedPixel(20),
                          // ),
                          animate: true,
                          primaryMeasureAxis: const NumericAxisSpec(
                              showAxisLine: true,
                              renderSpec: SmallTickRendererSpec(
                                  labelStyle: TextStyleSpec(
                                      color: MaterialPalette.white),
                                  lineStyle: LineStyleSpec(
                                      color: MaterialPalette.white))),
                          domainAxis: DateTimeAxisSpec(
                              tickFormatterSpec: BasicDateTimeTickFormatterSpec(
                                  (datetime) =>
                                      DateFormat('dd MMM').format(datetime)),
                              renderSpec: const SmallTickRendererSpec(
                                  labelStyle: TextStyleSpec(
                                      color: MaterialPalette.white)),
                              showAxisLine: true),
                          defaultRenderer: LineRendererConfig(
                              includeArea: true, includePoints: true)))
                ]);
              },
            ),
          );
        }
      },
    );
    // return TimeSeriesChart(
    //   _createSampleData(),
    //   animate: true,
    //   primaryMeasureAxis: const NumericAxisSpec(
    //       showAxisLine: true,
    //       renderSpec: SmallTickRendererSpec(
    //           labelStyle: TextStyleSpec(color: MaterialPalette.white),
    //           lineStyle: LineStyleSpec(color: MaterialPalette.white))),
    //   domainAxis: const DateTimeAxisSpec(
    //       renderSpec: SmallTickRendererSpec(
    //           labelStyle: TextStyleSpec(color: MaterialPalette.white)),
    //       showAxisLine: true),
    // );
  }
}
