// lib/routes/app_routes.dart

import 'package:daily_wellness/core/widgets/add_activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:daily_wellness/screens/login_screen.dart';
import 'package:daily_wellness/screens/dashboard_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String dashboard = '/dashboard';
  static const String addActivity = '/add-activity';

  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const Login(),
    dashboard: (context) => const Dashboard(),
    addActivity: (context) => const AddActivityScreen(),
  };
}
