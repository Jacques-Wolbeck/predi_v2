import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/shared/blocs/authentication/auth_bloc.dart';
import 'package:predi_v2/shared/blocs/authentication/auth_state.dart';
import 'package:predi_v2/shared/blocs/data/data_event.dart';

import '../../../../shared/blocs/data/data_bloc.dart';
import '../../../../shared/models/enums/data_type_enum.dart';
import '../../../../shared/models/patients/measurement_model.dart';
import '../../fields/measure_field.dart';

class EditMeasurementsAlert extends StatefulWidget {
  final MeasurementModel measure;
  const EditMeasurementsAlert({super.key, required this.measure});

  @override
  State<EditMeasurementsAlert> createState() => _EditMeasurementsAlertState();
}

class _EditMeasurementsAlertState extends State<EditMeasurementsAlert> {
  final _formKey = GlobalKey<FormState>();
  final weightFocus = FocusNode();
  final circumferenceFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Editar Medidas',
        textAlign: TextAlign.center,
        style: TextStyle(
            //fontWeight: FontWeight.bold,
            ),
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .4,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _measureTextForm(
                    DataTypeEnum.weight,
                    widget.measure.weight.toString(),
                    weightFocus,
                    circumferenceFocus,
                    (value) => widget.measure.weight = double.parse(value!)),
                Divider(
                    thickness: 3.0,
                    color: Theme.of(context).colorScheme.primary),
                _measureTextForm(
                    DataTypeEnum.circumference,
                    widget.measure.circumference.toString(),
                    circumferenceFocus,
                    null,
                    (value) =>
                        widget.measure.circumference = double.parse(value!)),
              ],
            ),
          ),
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
              final state = context.read<AuthBloc>().state;
              if (state is Authenticated) {
                context.read<DataBloc>().add(UpdateDataRequested(
                    patient: state.patient,
                    dataType: DataTypeEnum.measure,
                    data: widget.measure));
                Navigator.pop(context);
              }
            }
          },
          child: const Text('Editar',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancelar',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _measureTextForm(
      DataTypeEnum dataType,
      String hintText,
      FocusNode currentFocus,
      FocusNode? nextFocus,
      Function(String?) onSavedCallback) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          dataType.secondaryTitle,
          style: TextStyle(
              color: currentFocus.hasFocus
                  ? Theme.of(context).colorScheme.primary
                  : Colors.black),
        ),
        MeasureField(
          onSavedCallback: onSavedCallback,
          dataType: dataType,
          hintText: hintText,
          currentFocus: currentFocus,
          nextFocus: nextFocus,
        ),
        Text(
          dataType.measurementUnit!,
          style: TextStyle(
              color: currentFocus.hasFocus
                  ? Theme.of(context).colorScheme.primary
                  : Colors.black),
        )
      ],
    );
  }
}