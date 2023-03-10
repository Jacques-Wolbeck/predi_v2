import 'package:flutter/material.dart';

import '../widgets/commons/app_progress_indicator.dart';
import '../widgets/commons/app_title.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /*@override
  void initState() {
    Future.delayed(const Duration(seconds: 2))
        .then((_) => context.read<AuthBloc>().add(CheckLoginRequested()));

    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: /*BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacementNamed(context, '/home_screen',
                arguments: DefaultScreenArguments(
                    user: state.user, isFavoriteScreen: false));
          }
          if (state is UnAuthenticated) {
            Navigator.pushReplacementNamed(context, '/login_screen');
          }
        },
        child:*/
          Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppTitle(),
            const SizedBox(width: 16.0),
            const AppProgressIndicator(),
            TextButton(
              onPressed: () => throw Exception(),
              child: const Text("Throw Test Exception"),
            ),
          ],
        ),
      ),
    );
    //);
  }
}
