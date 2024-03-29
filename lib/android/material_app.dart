import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/android/routes.dart';
import 'package:predi_v2/android/screens/splash_screen.dart';
import 'package:predi_v2/android/widgets/custom/custom_text_theme.dart';
import 'package:predi_v2/shared/blocs/authentication/auth_bloc.dart';
import 'package:predi_v2/shared/blocs/data/data_bloc.dart';
import 'package:predi_v2/shared/blocs/patient/patient_bloc.dart';

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => PatientBloc()),
        BlocProvider(create: (context) => DataBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PreDi',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            //brightness: Brightness.dark,
          ),
          textTheme: CustomTextTheme(),
        ),
        onGenerateRoute: (route) => onGenerateRoute(route),
        home: const SplashScreen(),
      ),
    );
  }
}
