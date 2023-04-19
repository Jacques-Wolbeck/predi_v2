import 'package:flutter/material.dart';

import '../../../shared/models/enums/data_type_enum.dart';

class RateField extends StatelessWidget {
  final Function(String?)? onSavedCallback;
  final DataTypeEnum dataType;
  final FocusNode currentFocus;
  final FocusNode? nextFocus;
  final String hintText;
  final bool isEditField;

  const RateField(
      {super.key,
      required this.onSavedCallback,
      required this.dataType,
      required this.hintText,
      required this.currentFocus,
      this.nextFocus,
      this.isEditField = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        onSaved: onSavedCallback,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Vazio';
          }
          return null;
        },
        textAlign: isEditField ? TextAlign.start : TextAlign.center,
        focusNode: currentFocus,
        textInputAction:
            nextFocus == null ? TextInputAction.done : TextInputAction.next,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: isEditField ? dataType.primaryTitle : null,
          hintText: hintText,
          filled: true,
          border: isEditField
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(width: .8),
                )
              : null,
          enabledBorder: isEditField
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(width: .8),
                )
              : null,
        ),
      ),
    );
  }
}
