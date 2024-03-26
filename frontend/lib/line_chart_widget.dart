import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:frontend/trivia_score.dart';

class LineChartWidget extends StatelessWidget {
  final List<TriviaScore> scores;

  const LineChartWidget({super.key, required this.scores});

  List<Series<TriviaScore, DateTime>> _createSampleData() {
    return [
      Series(
          id: 'Score',
          data: scores,
          domainFn: (TriviaScore score, _) => score.date,
          measureFn: (TriviaScore score, _) => score.score)
    ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TimeSeriesChart(
      _createSampleData(),
      animate: true,
      primaryMeasureAxis: const NumericAxisSpec(
          showAxisLine: true,
          renderSpec: SmallTickRendererSpec(
              labelStyle: TextStyleSpec(color: MaterialPalette.white),
              lineStyle: LineStyleSpec(color: MaterialPalette.white))),
      domainAxis: const DateTimeAxisSpec(
          renderSpec: SmallTickRendererSpec(
              labelStyle: TextStyleSpec(color: MaterialPalette.white)),
          showAxisLine: true),
    );
  }
}
