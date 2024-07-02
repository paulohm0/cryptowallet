import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/graph_database_model.dart';

class MarketplaceGraph extends StatefulWidget {
  final List<GraphDatabase> graph;

  const MarketplaceGraph({
    super.key,
    required this.graph,
  });

  @override
  State<MarketplaceGraph> createState() => _MarketplaceGraphState();
}

class _MarketplaceGraphState extends State<MarketplaceGraph> {
  List<Color> gradientColor = [Colors.white, Colors.yellowAccent];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: AspectRatio(
        aspectRatio: 1.7,
        child: LineChart(
          mainGraph(),
        ),
      ),
    );
  }

  LineChartData mainGraph() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.white30,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.white30,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: const FlTitlesData(
        show: false,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 30,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 0,
            interval: 1,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.transparent, width: 1),
          left: BorderSide(color: Colors.transparent, width: 0),
        ),
      ),
      minX: 0,
      maxX: widget.graph.length.toDouble() - 1,
      minY: 0,
      maxY: _getMaxYValue(),
      lineBarsData: [
        LineChartBarData(
          //spots: ,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColor,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors:
                  gradientColor.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  List<FlSpot> _getSpots() {
    return widget.graph.asMap().entries.map((entry) {
      int index = entry.key;
      GraphDatabase data = entry.value;
      return FlSpot(
        index.toDouble(),
        double.tryParse(data.prices?.latestPrice?.amount?.amount ?? '0') ?? 0,
      );
    }).toList();
  }

  double _getMaxYValue() {
    double maxY = widget.graph
        .map((data) =>
            double.tryParse(data.prices?.latestPrice?.amount?.amount ?? '0') ??
            0)
        .reduce((a, b) => a > b ? a : b);
    return maxY + (maxY * 0.1);
  }
}
