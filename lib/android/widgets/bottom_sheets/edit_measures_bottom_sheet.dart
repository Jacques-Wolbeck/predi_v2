import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/blocs/authentication/auth_bloc.dart';
import '../../../shared/blocs/authentication/auth_state.dart';
import '../../../shared/blocs/data/data_bloc.dart';
import '../../../shared/blocs/data/data_event.dart';
import '../../../shared/models/enums/data_type_enum.dart';
import '../../../shared/models/patients/measurement_model.dart';
import '../fields/measure_field.dart';

class EditMeasuresBottomSheet extends StatefulWidget {
  final MeasurementModel measure;
  const EditMeasuresBottomSheet({super.key, required this.measure});

  @override
  State<EditMeasuresBottomSheet> createState() =>
      _EditMeasuresBottomSheetState();
}

class _EditMeasuresBottomSheetState extends State<EditMeasuresBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final weightFocus = FocusNode();
  final circumferenceFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Column(
                children: [
                  Divider(
                    thickness: 4.0,
                    indent: MediaQuery.of(context).size.width * 0.4,
                    endIndent: MediaQuery.of(context).size.width * 0.4,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  Text(
                    'Editar Medidas',
                    style: Theme.of(context).textTheme.headlineSmall!.merge(
                          TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                  ),
                ],
              ),
            ),
            _form(),
            const Divider(),
            _buttons(),
          ],
        ),
      ),
    );
  }

  Widget _form() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            MeasureField(
              dataType: DataTypeEnum.weight,
              hintText: widget.measure.weight.toString(),
              currentFocus: weightFocus,
              nextFocus: circumferenceFocus,
              isEditField: true,
              onSavedCallback: (value) =>
                  widget.measure.weight = double.parse(value!),
              prefixIcon: Icons.monitor_weight_outlined,
            ),
            MeasureField(
              dataType: DataTypeEnum.circumference,
              hintText: widget.measure.circumference.toString(),
              currentFocus: circumferenceFocus,
              isEditField: true,
              onSavedCallback: (value) =>
                  widget.measure.circumference = double.parse(value!),
              prefixIcon: Icons.straighten,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
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
            style: ElevatedButton.styleFrom(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Row(
              children: const [
                Icon(Icons.edit_outlined),
                SizedBox(width: 4.0),
                Text('Editar', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Row(
              children: const [
                Icon(Icons.cancel_outlined),
                SizedBox(width: 4.0),
                Text('Cancelar', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
