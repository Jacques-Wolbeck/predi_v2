import 'package:flutter/material.dart';
import 'package:predi_v2/android/screens/home_screen.dart';
import 'package:predi_v2/android/screens/login_screen.dart';
import 'package:predi_v2/android/screens/rate_screen.dart';
import 'package:predi_v2/android/screens/register_screen.dart';
import 'package:predi_v2/android/screens/update_data_screens/complete_personal_data_screen.dart';
import 'package:predi_v2/android/screens/update_data_screens/edit_personal_data_screen.dart';
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
    case '/edit_personal_data_screen':
      final args = settings.arguments as DefaultScreenArguments;
      return CustomPageRoute(
          child: EditPersonalDataScreen(
            patient: args.patient,
          ),
          settings: settings);
    case '/complete_personal_data_screen':
      final args = settings.arguments as DefaultScreenArguments;
      return CustomPageRoute(
          child: CompletePersonalDataScreen(
            patient: args.patient,
          ),
          settings: settings);
    case '/rate_screen':
      final args = settings.arguments as DefaultScreenArguments;
      return CustomPageRoute(
          child: RateScreen(
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
