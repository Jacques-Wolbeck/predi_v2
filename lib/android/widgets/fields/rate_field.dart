import 'package:flutter/material.dart';

import '../../../shared/models/enums/data_type_enum.dart';

class RateField extends StatelessWidget {
  final Function(String?)? onSavedCallback;
  final DataTypeEnum dataType;
  final String hintText;

  const RateField({
    super.key,
    required this.onSavedCallback,
    required this.dataType,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        onSaved: onSavedCallback,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Por favor digite uma ${dataType.value1}';
          }
          return null;
        },
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: dataType.value1,
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
          prefixIcon: const Icon(Icons.opacity),
        ),
      ),
    );
  }
}
