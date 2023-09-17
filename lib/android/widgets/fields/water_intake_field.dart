import 'package:flutter/material.dart';

class WaterIntakeField extends StatelessWidget {
  final Function(String?)? onSavedCallback;
  final double maxLevel;
  final FocusNode currentFocus;
  final String? initialValue;

  const WaterIntakeField({
    super.key,
    required this.onSavedCallback,
    required this.currentFocus,
    required this.maxLevel,
    this.initialValue,
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
            return 'Por favor digite um valor';
          }
          if (double.tryParse(value)! > maxLevel) {
            return 'Valor inválido ';
          }
          return null;
        },
        focusNode: currentFocus,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (term) {
          currentFocus.unfocus();
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Volume Consumido',
          hintText: '300.0 mL',
          filled: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(width: .8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(width: .8),
          ),
          contentPadding: const EdgeInsets.all(16.0),
          prefixIcon: Icon(
            Icons.water_drop,
            color: Theme.of(context).colorScheme.primary,
          ),
          suffix: Text('mL',
              style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        ),
      ),
    );
  }
}
