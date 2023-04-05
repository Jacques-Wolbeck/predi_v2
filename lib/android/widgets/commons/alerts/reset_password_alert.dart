import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/shared/blocs/authentication/auth_bloc.dart';
import 'package:predi_v2/shared/blocs/authentication/auth_event.dart';

import 'package:predi_v2/android/widgets/fields/login_fields/email_field.dart';

class ResetPasswordAlert extends StatefulWidget {
  const ResetPasswordAlert({super.key});

  @override
  State<ResetPasswordAlert> createState() => _ResetPasswordAlertState();
}

class _ResetPasswordAlertState extends State<ResetPasswordAlert> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocus = FocusNode();

  late String email;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Recuperar Senha',
        textAlign: TextAlign.center,
        style: TextStyle(
            //fontWeight: FontWeight.bold,
            ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                'Digite seu email de acesso ao aplicativo, para enviarmos as informações de recuperção de senha.'),
            Form(
                key: _formKey,
                child: EmailField(
                    onSavedCallback: (value) => email = value!,
                    currentFocus: _emailFocus)),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              context
                  .read<AuthBloc>()
                  .add(ResetPasswordRequested(email: email));
              Navigator.pop(context);
            }
          },
          child: const Text(
            'Enviar',
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
