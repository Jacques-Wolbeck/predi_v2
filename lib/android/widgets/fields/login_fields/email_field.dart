import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final Function(String?)? onSavedCallback;
  final FocusNode currentFocus;
  final FocusNode? nextFocus;

  const EmailField(
      {super.key,
      required this.onSavedCallback,
      required this.currentFocus,
      this.nextFocus});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        onSaved: onSavedCallback,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Por favor digite um email';
          }
          if (!emailValid(value)) {
            return 'Por favor digite um email válido.';
          }
          return null;
        },
        focusNode: currentFocus,
        textInputAction: nextFocus == null
            ? TextInputAction.done
            : TextInputAction
                .next, //checa se existe um prox form para passar o foco
        onFieldSubmitted: (term) {
          if (nextFocus != null) {
            currentFocus.unfocus();
            FocusScope.of(context).requestFocus(nextFocus);
            //aqui ele faz a ação de desativar o foco atual e dps passar pro prox
          }
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email',
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(width: .8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(width: .8),
          ),
          contentPadding: const EdgeInsets.all(16.0),
          prefixIcon: const Icon(Icons.email_outlined),
        ),
      ),
    );
  }

  bool emailValid(String email) {
    final RegExp regex = RegExp(
        r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");
    return regex.hasMatch(email);
  }
}
