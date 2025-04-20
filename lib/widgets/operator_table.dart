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
    return Card(
      elevation: 2,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Operator')),
            DataColumn(label: Text('Shift')),
            DataColumn(label: Text('Machine')),
            DataColumn(label: Text('Production')),
            DataColumn(label: Text('Quality')),
            DataColumn(label: Text('Status')),
          ],
          rows: operators.map((operator) {
            return DataRow(
              cells: [
                DataCell(Text(operator.name)),
                DataCell(Text(operator.shift)),
                DataCell(Text(operator.machine)),
                DataCell(Text(operator.totalProduction.toString())),
                DataCell(Text('${operator.qualityRate}%')),
                DataCell(_buildStatusChip(operator.status)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    IconData icon;

    switch (status) {
      case 'active':
        color = Colors.green;
        icon = Icons.check_circle;
        break;
      case 'break':
        color = Colors.orange;
        icon = Icons.coffee;
        break;
      case 'inactive':
        color = Colors.grey;
        icon = Icons.cancel;
        break;
      default:
        color = Colors.blue;
        icon = Icons.info;
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
      avatar: Icon(
        icon,
        color: Colors.white,
        size: 12,
      ),
      padding: EdgeInsets.zero,
      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}
