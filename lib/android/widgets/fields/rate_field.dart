import 'package:flutter/material.dart';

import '../../../shared/models/enums/data_type_enum.dart';

//TODO If the user put a dot after the number, the double parse will throw an exeption, example: "80.0." this throw an error
class RateField extends StatelessWidget {
  final Function(String?)? onSavedCallback;
  final DataTypeEnum dataType;
  final FocusNode currentFocus;
  final FocusNode? nextFocus;
  final String hintText;
  final bool isEditField;
  final IconData? prefixIcon;

  const RateField(
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
          var parsedValue = double.parse(value);
          if (dataType == DataTypeEnum.glycatedHemoglobin &&
              parsedValue > 100) {
            return 'Valor Inválido';
          }
          if (dataType == DataTypeEnum.fastingGlucose && parsedValue > 700.0) {
            return 'Valor Inválido';
          }
          if (dataType == DataTypeEnum.glucose75g && parsedValue > 700.0) {
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
