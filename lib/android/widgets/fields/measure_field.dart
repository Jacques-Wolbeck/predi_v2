import 'package:flutter/material.dart';

import '../../../shared/models/enums/data_type_enum.dart';

class MeasureField extends StatelessWidget {
  final Function(String?)? onSavedCallback;
  final DataTypeEnum dataType;
  final FocusNode currentFocus;
  final FocusNode? nextFocus;
  final String hintText;
  final bool isEditField;
  final IconData? prefixIcon;

  const MeasureField(
      {super.key,
      required this.onSavedCallback,
      required this.dataType,
      required this.hintText,
      required this.currentFocus,
      this.prefixIcon,
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
          var parsedValue = double.tryParse(value);
          if (parsedValue == null) {
            return 'Valor Inválido';
          }
          if (dataType == DataTypeEnum.weight && parsedValue > 600.0) {
            return 'Valor Inválido';
          }
          if (dataType == DataTypeEnum.circumference && parsedValue > 500.0) {
            return 'Valor Inválido';
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
          prefixIcon: isEditField ? Icon(prefixIcon) : null,
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
