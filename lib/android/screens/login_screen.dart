import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/android/widgets/buttons/google_login_button.dart';
import 'package:predi_v2/android/widgets/buttons/login_button.dart';
import 'package:predi_v2/android/widgets/alerts/reset_password_alert.dart';

import '../../shared/blocs/authentication/auth_bloc.dart';
import '../../shared/blocs/authentication/auth_state.dart';
import '../widgets/commons/app_progress_indicator.dart';
import '../widgets/commons/app_screen_args.dart';
import '../widgets/commons/app_snack_bar.dart';
import '../widgets/commons/app_title.dart';
import '../widgets/fields/login_fields/email_field.dart';
import '../widgets/fields/login_fields/password_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final _loginInfo = <String, String>{};
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  @override
  void dispose() {
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            if (state.patient.birthDate == null) {
              Navigator.pushReplacementNamed(
                  context, '/complete_personal_data_screen',
                  arguments: DefaultScreenArguments(patient: state.patient));
            } else if (state.patient.isSurveyCompleted == null ||
                !state.patient.isSurveyCompleted!) {
              Navigator.pushReplacementNamed(context, '/survey_screen',
                  arguments: DefaultScreenArguments(patient: state.patient));
            } else {
              Navigator.pushReplacementNamed(context, '/home_screen',
                  arguments: DefaultScreenArguments(patient: state.patient));
            }
          }
          if (state is FeedbackMessage) {
            ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar(message: state.message).snack(context));
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar(message: state.error, isError: true)
                    .snack(context));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return const SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppTitle(),
                        SizedBox(width: 16.0),
                        AppProgressIndicator(),
                      ]),
                ),
              ),
            );
          }
          if (state is UnAuthenticated) {
            return _loginArea();
          }
          return Container();
        },
      ),
    );
  }

  Widget _loginArea() {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              const AppTitle(),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    EmailField(
                      onSavedCallback: (value) => _loginInfo['email'] = value!,
                      currentFocus: emailFocus,
                      nextFocus: passwordFocus,
                    ),
                    PasswordField(
                      onSavedCallback: (value) =>
                          _loginInfo['password'] = value!,
                      currentFocus: passwordFocus,
                    ),
                  ],
                ),
              ),
              LoginButton(formKey: _formkey, loginInfo: _loginInfo),
              const GoogleLoginButton(),
              TextButton(
                onPressed: () => showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const ResetPasswordAlert()),
                child: const Text(
                  'Esqueceu a senha?',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Novo por aqui?'),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/register_screen'),
                    child: const Text(
                      'Crie sua conta',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
