import 'package:flutter/material.dart';
import 'package:production_monitor/models/operator_data.dart';

class OperatorTable extends StatelessWidget {
  final List<OperatorData> operators;

  const OperatorTable({
    Key? key,
    required this.operators,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: isSmallScreen ? 20 : 40,
          headingTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isSmallScreen ? 12 : 14,
          ),
          dataTextStyle: TextStyle(
            fontSize: isSmallScreen ? 12 : 14,
          ),
          columns: [
            DataColumn(label: Text('Operator')),
            DataColumn(label: Text('Shift')),
            DataColumn(label: Text('Machine')),
            DataColumn(
              label: Text('Production'),
              numeric: true,
            ),
            DataColumn(
              label: Text('Quality'),
              numeric: true,
            ),
            DataColumn(label: Text('Status')),
          ],
          rows: operators.map((operator) => DataRow(
            cells: [
              DataCell(Text(operator.name)),
              DataCell(Text(operator.shift)),
              DataCell(Text(operator.machine)),
              DataCell(Text(operator.totalProduction.toString())),
              DataCell(Text('${operator.qualityRate}%')),
              DataCell(_buildStatusChip(operator.status)),
            ],
          )).toList(),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'active':
        color = Colors.green;
        break;
      case 'break':
        color = Colors.orange;
        break;
      default:
        color = Colors.grey;
    }

    return Chip(
      label: Text(
        status,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      backgroundColor: color,
      padding: EdgeInsets.zero,
      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
