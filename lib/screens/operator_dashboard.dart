import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:production_monitor/providers/auth_provider.dart';
import 'package:production_monitor/providers/production_provider.dart';
import 'package:production_monitor/widgets/app_drawer.dart';
import 'package:production_monitor/widgets/production_metrics.dart';
import 'package:production_monitor/widgets/production_chart.dart';
import 'dart:async'; // Add this import at the top


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

    // Use Future.microtask to access providers in initState
    Future.microtask(() {
      context.read<ProductionProvider>();
      context.read<AuthProvider>();
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
    final productionProvider = context.watch<ProductionProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Operator Dashboard'),
        actions: [
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (provider.summary != null)
                    ProductionMetrics(summary: provider.summary!),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 400,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Hourly tab
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Hourly Production Quality',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Production metrics for the last 12 hours',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Expanded(
                                  child: ProductionChart(data: provider.hourlyData),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        // Daily tab
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Daily Production Quality',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Production metrics for the last 7 days',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Expanded(
                                  child: ProductionChart(data: provider.dailyData),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        // Weekly tab
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Weekly Production Quality',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Production metrics for the last 4 weeks',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Expanded(
                                  child: ProductionChart(data: provider.weeklyData),
                                ),
                              ],
                            ),
                          ),
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
}
