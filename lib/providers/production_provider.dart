import 'package:flutter/foundation.dart';
import 'package:production_monitor/models/production_data.dart';
import 'package:production_monitor/models/operator_data.dart';
import 'package:production_monitor/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:production_monitor/providers/auth_provider.dart';
import 'package:production_monitor/screens/operator_dashboard.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductionProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Production Monitor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const OperatorDashboard(), // Your initial screen
    );
  }
}

class ProductionProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  ProductionSummary? _summary;
  List<ProductionData> _hourlyData = [];
  List<ProductionData> _dailyData = [];
  List<ProductionData> _weeklyData = [];
  List<OperatorData> _operatorData = [];
  bool _isLoading = false;

  ProductionSummary? get summary => _summary;
  List<ProductionData> get hourlyData => _hourlyData;
  List<ProductionData> get dailyData => _dailyData;
  List<ProductionData> get weeklyData => _weeklyData;
  List<OperatorData> get operatorData => _operatorData;
  bool get isLoading => _isLoading;

  Future<void> fetchProductionData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await _apiService.fetchProductionData();
      _summary = data.summary;
      _hourlyData = data.hourly;
      _dailyData = data.daily;
      _weeklyData = data.weekly;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> fetchOperatorData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _operatorData = await _apiService.fetchOperatorData();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
