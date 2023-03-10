import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/android/screens/splash_screen.dart';
import 'package:predi_v2/android/widgets/custom/custom_text_theme.dart';

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PreDi',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        textTheme: CustomTextTheme(),
      ),
      //onGenerateRoute: (route) => onGenerateRoute(route),
      home: const SplashScreen(),
    );
  }
}
