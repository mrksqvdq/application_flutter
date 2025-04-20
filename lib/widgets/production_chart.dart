import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:production_monitor/models/production_data.dart';

class ProductionChart extends StatelessWidget {
  final List<ProductionData> data;

  const ProductionChart({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? const Center(child: Text('No data available'))
        : BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: _getMaxY(),
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.blueGrey.shade800,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    String label;
                    switch (rodIndex) {
                      case 0:
                        label = 'Total: ${rod.toY.round()}';
                        break;
                      case 1:
                        label = 'Good: ${rod.toY.round()}';
                        break;
                      case 2:
                        label = 'Bad: ${rod.toY.round()}';
                        break;
                      default:
                        label = '';
                    }
                    return BarTooltipItem(
                      label,
                      const TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (value < 0 || value >= data.length) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          data[value.toInt()].time,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: FlGridData(
                show: true,
                horizontalInterval: _getMaxY() / 5,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.grey.shade300,
                    strokeWidth: 1,
                    dashArray: [5, 5],
                  );
                },
                drawVerticalLine: false,
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: _getBarGroups(),
            ),
          );
  }

  double _getMaxY() {
    double maxY = 0;
    for (var item in data) {
      if (item.total > maxY) {
        maxY = item.total.toDouble();
      }
    }
    return maxY * 1.2; // Add 20% padding
  }

  List<BarChartGroupData> _getBarGroups() {
    return List.generate(data.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data[index].total.toDouble(),
            color: Colors.blue,
            width: 8,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
          BarChartRodData(
            toY: data[index].good.toDouble(),
            color: Colors.green,
            width: 8,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
          BarChartRodData(
            toY: data[index].bad.toDouble(),
            color: Colors.red,
            width: 8,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
        ],
      );
    });
  }
}
