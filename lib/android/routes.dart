import 'package:flutter/material.dart';
import 'package:predi_v2/android/screens/home_screen.dart';
import 'package:predi_v2/android/screens/login_screen.dart';
import 'package:predi_v2/android/screens/register_screen.dart';
import 'package:predi_v2/android/widgets/commons/app_screen_args.dart';
import 'package:predi_v2/android/widgets/custom/custom_page_route.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/home_screen':
      final args = settings.arguments as DefaultScreenArguments;
      return CustomPageRoute(
          child: HomeScreen(
            patient: args.patient,
          ),
          settings: settings);
    case '/register_screen':
      return CustomPageRoute(child: const RegisterScreen());
    case '/login_screen':
    default:
      return CustomPageRoute(child: const LoginScreen());
  }
}
