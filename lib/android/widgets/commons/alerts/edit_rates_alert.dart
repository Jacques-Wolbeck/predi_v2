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

class _EditRatesAlertState extends State<EditRatesAlert> {
  final _formKey = GlobalKey<FormState>();
  final glycatedFocus = FocusNode();
  final fastingFocus = FocusNode();
  final glucose75Focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      iconPadding: EdgeInsets.zero,
      icon: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0)),
        ),
        child: Text(
          'Editar Taxas',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall!.merge(
                TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
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
                Divider(color: Theme.of(context).colorScheme.primary),
                _rateTextForm(
                    DataTypeEnum.fastingGlucose,
                    widget.rate.fastingGlucose.toString(),
                    fastingFocus,
                    glucose75Focus,
                    (value) =>
                        widget.rate.fastingGlucose = double.parse(value!)),
                Divider(color: Theme.of(context).colorScheme.primary),
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

  Widget _rateTextForm(
      DataTypeEnum dataType,
      String hintText,
      FocusNode currentFocus,
      FocusNode? nextFocus,
      Function(String?) onSavedCallback) {
    return RateField(
      onSavedCallback: onSavedCallback,
      dataType: dataType,
      hintText: hintText,
      currentFocus: currentFocus,
      nextFocus: nextFocus,
      isEditField: true,
    );
  }
}
