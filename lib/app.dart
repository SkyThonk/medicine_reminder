import 'package:flutter/material.dart';
import 'package:medicine_reminder/screens/dashboard/dashboard_screen.dart';
import './utils/app_routes.dart';
import './screens/login_signup/login_screen.dart';
import './screens/login_signup/signup_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine Reminder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.signup: (context) => const SignupScreen(),
        AppRoutes.dashboard: (context) => const DashBoardScreen()
      },
    );
  }
}
