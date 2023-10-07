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
      iconPadding: EdgeInsets.zero,
      icon: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0)),
        ),
        child: Text(
          'Recuperar Senha',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall!.merge(
                TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
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
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              context
                  .read<AuthBloc>()
                  .add(ResetPasswordRequested(email: email));
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.send_outlined),
              SizedBox(width: 4.0),
              Text('Enviar', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Icon(Icons.cancel_outlined),
        ),
      ],
    );
  }
}
