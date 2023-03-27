import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/blocs/authentication/auth_bloc.dart';
import '../../../shared/blocs/authentication/auth_event.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 64.0),
      child: ElevatedButton(
        onPressed: () => context.read<AuthBloc>().add(GoogleSignInRequested()),
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          maximumSize: const Size(double.infinity, 45.0),
          //minimumSize: const Size(300, 45.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              "assets/images/google_logo.png",
              height: 20.0,
              width: 20.0,
            ),
            const SizedBox(width: 8.0),
            const Text('Entrar com Gmail'),
          ],
        ),
      ),
    );
  }
}
