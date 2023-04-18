import 'package:flutter/material.dart';

class DefaultField extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final Function(String?)? onSavedCallback;
  final FocusNode currentFocus;
  final FocusNode? nextFocus;
  final String? initialValue;
  final String? hintText;

  const DefaultField({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    required this.onSavedCallback,
    required this.currentFocus,
    this.initialValue,
    this.hintText,
    this.keyboardType = TextInputType.name,
    this.nextFocus,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        initialValue: initialValue ?? '',
        onSaved: onSavedCallback,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Por favor digite um $labelText';
          }
          return null;
        },
        focusNode: currentFocus,
        textInputAction:
            nextFocus == null ? TextInputAction.done : TextInputAction.next,
        onFieldSubmitted: (term) {
          if (nextFocus != null) {
            currentFocus.unfocus();
            FocusScope.of(context).requestFocus(nextFocus);
          }
        },
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
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
          prefixIcon: Icon(prefixIcon),
        ),
      ),
    );
  }
}
