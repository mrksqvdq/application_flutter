import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:production_monitor/providers/auth_provider.dart';
import 'package:production_monitor/providers/production_provider.dart';
import 'package:production_monitor/screens/login_screen.dart';
import 'package:production_monitor/screens/manager_dashboard.dart';
import 'package:production_monitor/screens/operator_dashboard.dart';
import 'package:production_monitor/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductionProvider()),
      ],
      child: MaterialApp(
        title: 'Production Monitor',
        theme: AppTheme.lightTheme,
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            if (!authProvider.isAuthenticated) {
              return const LoginScreen();
            } else {
              if (authProvider.userRole == 'manager') {
                return const ManagerDashboard();
              } else {
                return const OperatorDashboard();
              }
            }
          },
        ),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/manager_dashboard': (context) => const ManagerDashboard(),
          '/operator_dashboard': (context) => const OperatorDashboard(),
        },
      ),
    );
  }
}
