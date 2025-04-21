import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:production_monitor/models/production_data.dart';
import 'package:production_monitor/providers/auth_provider.dart';
import 'package:production_monitor/providers/production_provider.dart';
import 'package:production_monitor/widgets/app_drawer.dart';
import 'package:production_monitor/widgets/production_metrics.dart';
import 'package:production_monitor/widgets/production_chart.dart';
import 'dart:async';

class OperatorDashboard extends StatefulWidget {
  const OperatorDashboard({Key? key}) : super(key: key);

  @override
  _OperatorDashboardState createState() => _OperatorDashboardState();
}

class _OperatorDashboardState extends State<OperatorDashboard> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ProductionProvider _productionProvider;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Initialize the provider
    _productionProvider = Provider.of<ProductionProvider>(context, listen: false);
    _loadData();

    // Set up periodic refresh (every 30 seconds)
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _loadData();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadData() async {
    await _productionProvider.fetchProductionData();
  }

  @override
  Widget build(BuildContext context) {
    final username = Provider.of<AuthProvider>(context).username;
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Operator Dashboard',
          style: TextStyle(fontSize: isSmallScreen ? 18 : 20),
        ),
        actions: [
          if (!isSmallScreen)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Hello, $username',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: isSmallScreen,
          tabs: const [
            Tab(text: 'Hourly'),
            Tab(text: 'Daily'),
            Tab(text: 'Weekly'),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      body: Consumer<ProductionProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.summary == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: _loadData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(isSmallScreen ? 8.0 : 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (provider.summary != null)
                    ProductionMetrics(summary: provider.summary!),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: isSmallScreen ? 300 : 400,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Hourly tab
                        _buildChartCard(
                          'Hourly Production Quality',
                          'Production metrics for the last 12 hours',
                          provider.hourlyData,
                          isSmallScreen,
                        ),
                        
                        // Daily tab
                        _buildChartCard(
                          'Daily Production Quality',
                          'Production metrics for the last 7 days',
                          provider.dailyData,
                          isSmallScreen,
                        ),
                        
                        // Weekly tab
                        _buildChartCard(
                          'Weekly Production Quality',
                          'Production metrics for the last 4 weeks',
                          provider.weeklyData,
                          isSmallScreen,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildChartCard(String title, String subtitle, List<ProductionData> data, bool isSmallScreen) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 8.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: isSmallScreen ? 16 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: isSmallScreen ? 12 : 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ProductionChart(data: data),
            ),
          ],
        ),
      ),
    );
  }
}
