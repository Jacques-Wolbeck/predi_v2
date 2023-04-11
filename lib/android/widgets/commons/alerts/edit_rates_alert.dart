import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/shared/blocs/authentication/auth_bloc.dart';
import 'package:predi_v2/shared/blocs/authentication/auth_state.dart';
import 'package:predi_v2/shared/blocs/data/data_event.dart';

import '../../../../shared/blocs/data/data_bloc.dart';
import '../../../../shared/models/enums/data_type_enum.dart';
import '../../../../shared/models/patients/rate_model.dart';
import '../../fields/rate_field.dart';

class EditRatesAlert extends StatefulWidget {
  final RateModel rate;
  const EditRatesAlert({super.key, required this.rate});

  @override
  State<EditRatesAlert> createState() => _EditRatesAlertState();
}

//TODO Its necessary to apply bloc listener here
class _EditRatesAlertState extends State<EditRatesAlert> {
  final _formKey = GlobalKey<FormState>();
  final glycatedFocus = FocusNode();
  final fastingFocus = FocusNode();
  final glucose75Focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Editar Taxas',
        textAlign: TextAlign.center,
        style: TextStyle(
            //fontWeight: FontWeight.bold,
            ),
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .6,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _rateTextForm(
                    DataTypeEnum.glycatedHemoglobin,
                    widget.rate.glycatedHemoglobin.toString(),
                    glycatedFocus,
                    fastingFocus,
                    (value) =>
                        widget.rate.glycatedHemoglobin = double.parse(value!)),
                Divider(
                    thickness: 4.0,
                    color: Theme.of(context).colorScheme.primary),
                _rateTextForm(
                    DataTypeEnum.fastingGlucose,
                    widget.rate.fastingGlucose.toString(),
                    fastingFocus,
                    glucose75Focus,
                    (value) =>
                        widget.rate.fastingGlucose = double.parse(value!)),
                Divider(
                    thickness: 4.0,
                    color: Theme.of(context).colorScheme.primary),
                _rateTextForm(
                    DataTypeEnum.glucose75g,
                    widget.rate.glucose75g.toString(),
                    glucose75Focus,
                    null,
                    (value) => widget.rate.glucose75g = double.parse(value!)),
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
                    dataType: DataTypeEnum.rate,
                    data: widget.rate));
                Navigator.pop(context);
              }
            }
          },
          child: const Text(
            'Editar',
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancelar'),
        ),
      ],
    );
  }

  Widget _rateTextForm(
      DataTypeEnum dataType,
      String hintText,
      FocusNode currentFocus,
      FocusNode? nextFocus,
      Function(String?) onSavedCallback) {
    return Expanded(
      child: Column(
        children: [
          Text(
            dataType.secondaryTitle,
            style: TextStyle(
                color: currentFocus.hasFocus
                    ? Theme.of(context).colorScheme.primary
                    : Colors.black),
          ),
          RateField(
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
      ),
    );
  }
}
