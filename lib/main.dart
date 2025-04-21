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
        home: const LoginScreen(),
        onGenerateRoute: (settings) {
          // Clear the navigation stack when going to login
          if (settings.name == '/login') {
            return MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            );
          }
          return null;
        },
      ),
    );
  }
}
