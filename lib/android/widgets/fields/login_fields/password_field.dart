import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final Function(String?)? onSavedCallback;
  final FocusNode currentFocus;
  final FocusNode? nextFocus;

  const PasswordField(
      {super.key,
      required this.onSavedCallback,
      required this.currentFocus,
      this.nextFocus});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool visibility = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        onSaved: widget.onSavedCallback,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Por favor digite uma senha.';
          } else if (value.length < 6) {
            return 'Por favor digite uma senha com 6 ou mais caracteres';
          }
          return null;
        },
        focusNode: widget.currentFocus,
        textInputAction: widget.nextFocus == null
            ? TextInputAction.done
            : TextInputAction.next,
        onFieldSubmitted: (term) {
          if (widget.nextFocus != null) {
            widget.currentFocus.unfocus();
            FocusScope.of(context).requestFocus(widget.nextFocus);
          }
        },
        keyboardType: TextInputType.visiblePassword,
        obscureText: !visibility,
        decoration: InputDecoration(
          labelText: 'Senha',
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(width: .8),
          ),
          suffixIcon: IconButton(
            icon: visibility
                ? const Icon(
                    Icons.visibility,
                  )
                : const Icon(
                    Icons.visibility_off,
                  ),
            onPressed: () {
              setState(
                () {
                  visibility = !visibility;
                },
              );
            },
          ),
          contentPadding: const EdgeInsets.all(16.0),
        ),
      ),
    );
  }
}
