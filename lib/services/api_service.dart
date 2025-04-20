import 'dart:async';
import 'package:production_monitor/models/production_data.dart';
import 'package:production_monitor/models/operator_data.dart';

class ApiService {
  // Simulate API calls with mock data
  Future<ProductionResponse> fetchProductionData() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock data
    final summary = ProductionSummary(
      total: 1250,
      good: 1175,
      bad: 75,
      trend: 5.2,
    );

    final hourlyData = [
      ProductionData(time: "08:00", total: 120, good: 112, bad: 8),
      ProductionData(time: "09:00", total: 135, good: 128, bad: 7),
      ProductionData(time: "10:00", total: 142, good: 135, bad: 7),
      ProductionData(time: "11:00", total: 125, good: 118, bad: 7),
      ProductionData(time: "12:00", total: 110, good: 102, bad: 8),
      ProductionData(time: "13:00", total: 128, good: 120, bad: 8),
      ProductionData(time: "14:00", total: 145, good: 138, bad: 7),
      ProductionData(time: "15:00", total: 130, good: 122, bad: 8),
      ProductionData(time: "16:00", total: 115, good: 110, bad: 5),
      ProductionData(time: "17:00", total: 100, good: 95, bad: 5),
    ];

    final dailyData = [
      ProductionData(time: "Mon", total: 950, good: 902, bad: 48),
      ProductionData(time: "Tue", total: 1050, good: 997, bad: 53),
      ProductionData(time: "Wed", total: 1100, good: 1045, bad: 55),
      ProductionData(time: "Thu", total: 1000, good: 950, bad: 50),
      ProductionData(time: "Fri", total: 1200, good: 1140, bad: 60),
      ProductionData(time: "Sat", total: 800, good: 760, bad: 40),
      ProductionData(time: "Sun", total: 500, good: 475, bad: 25),
    ];

    final weeklyData = [
      ProductionData(time: "Week 1", total: 6500, good: 6175, bad: 325),
      ProductionData(time: "Week 2", total: 7000, good: 6650, bad: 350),
      ProductionData(time: "Week 3", total: 6800, good: 6460, bad: 340),
      ProductionData(time: "Week 4", total: 7200, good: 6840, bad: 360),
    ];

    return ProductionResponse(
      summary: summary,
      hourly: hourlyData,
      daily: dailyData,
      weekly: weeklyData,
    );
  }

  Future<List<OperatorData>> fetchOperatorData() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock data
    return [
      OperatorData(
        id: "op1",
        name: "John Smith",
        shift: "Morning",
        machine: "Machine A",
        totalProduction: 450,
        qualityRate: 96,
        status: "active",
      ),
      OperatorData(
        id: "op2",
        name: "Sarah Johnson",
        shift: "Morning",
        machine: "Machine B",
        totalProduction: 425,
        qualityRate: 94,
        status: "break",
      ),
      OperatorData(
        id: "op3",
        name: "Michael Brown",
        shift: "Afternoon",
        machine: "Machine A",
        totalProduction: 375,
        qualityRate: 92,
        status: "active",
      ),
      OperatorData(
        id: "op4",
        name: "Emily Davis",
        shift: "Afternoon",
        machine: "Machine B",
        totalProduction: 0,
        qualityRate: 0,
        status: "inactive",
      ),
    ];
  }
}
