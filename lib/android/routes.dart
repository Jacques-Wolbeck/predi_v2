import 'package:flutter/material.dart';
import 'package:predi_v2/android/screens/home_screen.dart';
import 'package:predi_v2/android/screens/login_screen.dart';
import 'package:predi_v2/android/screens/rates/rates_list_screen.dart';
import 'package:predi_v2/android/screens/rates/rates_screen.dart';
import 'package:predi_v2/android/screens/register_screen.dart';
import 'package:predi_v2/android/screens/personal_data/complete_personal_data_screen.dart';
import 'package:predi_v2/android/screens/personal_data/edit_personal_data_screen.dart';
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
    case '/rates_screen':
      final args = settings.arguments as DefaultScreenArguments;
      return CustomPageRoute(
          child: RatesScreen(
            patient: args.patient,
          ),
          settings: settings);
    case '/rates_list_screen':
      final args = settings.arguments as DefaultScreenArguments;
      return CustomPageRoute(
          child: RatesListScreen(
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
