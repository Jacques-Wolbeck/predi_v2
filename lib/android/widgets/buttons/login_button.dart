import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/shared/blocs/authentication/auth_event.dart';

import '../../../shared/blocs/authentication/auth_bloc.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, String> loginInfo;

  const LoginButton({
    super.key,
    required this.formKey,
    required this.loginInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            context.read<AuthBloc>().add(EmailPasswordSignInRequested(
                email: loginInfo['email']!, password: loginInfo['password']!));
          }
        },
        style: ElevatedButton.styleFrom(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            minimumSize: const Size(double.infinity, 45.0)),
        child: const Text(
          "Login",
        ),
      ),
    );
  }
}
