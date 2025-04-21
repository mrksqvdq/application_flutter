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
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: data.isEmpty ? 100 : data.map((e) => e.total.toDouble()).reduce((a, b) => a > b ? a : b) * 1.2,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.white,
            tooltipRoundedRadius: 8,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final dataPoint = data[groupIndex];
              String value = '';
              switch (rodIndex) {
                case 0:
                  value = dataPoint.total.toString();
                  break;
                case 1:
                  value = dataPoint.good.toString();
                  break;
                case 2:
                  value = dataPoint.bad.toString();
                  break;
              }
              return BarTooltipItem(
                value,
                TextStyle(
                  color: Colors.black,
                  fontSize: isSmallScreen ? 10 : 12,
                  fontWeight: FontWeight.bold,
                ),
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
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    data[value.toInt()].time,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: isSmallScreen ? 8 : 10,
                    ),
                  ),
                );
              },
              reservedSize: isSmallScreen ? 24 : 30,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    value.toInt().toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: isSmallScreen ? 8 : 10,
                    ),
                  ),
                );
              },
              reservedSize: isSmallScreen ? 28 : 36,
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
          horizontalInterval: 1,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey.withOpacity(0.2),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: data.asMap().entries.map((entry) {
          final dataPoint = entry.value;
          return BarChartGroupData(
            x: entry.key,
            barRods: [
              BarChartRodData(
                toY: dataPoint.total.toDouble(),
                color: Colors.blue,
                width: isSmallScreen ? 8 : 12,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
              ),
              BarChartRodData(
                toY: dataPoint.good.toDouble(),
                color: Colors.green,
                width: isSmallScreen ? 8 : 12,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
              ),
              BarChartRodData(
                toY: dataPoint.bad.toDouble(),
                color: Colors.red,
                width: isSmallScreen ? 8 : 12,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
