import 'package:flutter/material.dart';
import 'package:production_monitor/models/production_data.dart';

class ProductionMetrics extends StatelessWidget {
  final ProductionSummary summary;

  const ProductionMetrics({
    Key? key,
    required this.summary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final qualityRate = summary.total > 0 ? (summary.good / summary.total * 100).round() : 0;
    final defectRate = summary.total > 0 ? (summary.bad / summary.total * 100).round() : 0;
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Production Summary',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: isSmallScreen ? 1 : 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          childAspectRatio: isSmallScreen ? 3 : 1.5,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // Total Production
            _buildMetricCard(
              context,
              title: 'Total Production',
              value: summary.total.toString(),
              subtitle: summary.trend > 0
                  ? '+${summary.trend}% from last period'
                  : '${summary.trend}% from last period',
              subtitleColor: summary.trend > 0 ? Colors.green : Colors.red,
              icon: Icons.inventory,
              iconColor: Colors.blue,
            ),
            
            // Good Quality
            _buildMetricCard(
              context,
              title: 'Good Quality',
              value: summary.good.toString(),
              subtitle: '$qualityRate% of total',
              subtitleColor: Colors.grey,
              icon: Icons.check_circle,
              iconColor: Colors.green,
            ),
            
            // Bad Quality
            _buildMetricCard(
              context,
              title: 'Bad Quality',
              value: summary.bad.toString(),
              subtitle: '$defectRate% defect rate',
              subtitleColor: Colors.grey,
              icon: Icons.error,
              iconColor: Colors.red,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    BuildContext context, {
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    Color? subtitleColor,
    Color? iconColor,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                Icon(
                  icon,
                  size: 20,
                  color: iconColor,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: subtitleColor ?? Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
