import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/blocs/authentication/auth_bloc.dart';
import '../../shared/blocs/authentication/auth_event.dart';
import '../../shared/blocs/authentication/auth_state.dart';
import '../widgets/commons/app_progress_indicator.dart';
import '../widgets/commons/app_screen_args.dart';
import '../widgets/commons/app_title.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2))
        .then((_) => context.read<AuthBloc>().add(CheckLoginRequested()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacementNamed(context, '/home_screen',
                arguments: DefaultScreenArguments(patient: state.patient));
          }
          if (state is UnAuthenticated) {
            Navigator.pushReplacementNamed(context, '/login_screen');
          }
        },
        child: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTitle(),
              SizedBox(width: 16.0),
              AppProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
