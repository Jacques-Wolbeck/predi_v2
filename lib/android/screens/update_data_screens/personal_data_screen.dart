import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

import '../../widgets/buttons/update_buttons/personal_data_button.dart';
import '../../widgets/fields/default_field.dart';
import '../../widgets/fields/personal_data_fields/date_field.dart';

class PersonalDataScreen extends StatefulWidget {
  final PatientModel patient;
  const PersonalDataScreen({super.key, required this.patient});

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  final _formkey = GlobalKey<FormState>();

  final nameFocus = FocusNode();
  final birthdateFocus = FocusNode();
  final heightFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: const Text('Dados Gerais'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              const Text('Dados Pessoais',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              DefaultField(
                labelText: 'Nome',
                prefixIcon: Icons.person_2_outlined,
                onSavedCallback: (value) => widget.patient.name = value,
                currentFocus: nameFocus,
                nextFocus: heightFocus,
                initialValue: widget.patient.name!,
              ),
              DefaultField(
                labelText: 'Altura',
                prefixIcon: Icons.height,
                onSavedCallback: (value) =>
                    widget.patient.height = double.parse(value!),
                currentFocus: heightFocus,
                nextFocus: birthdateFocus,
                initialValue: widget.patient.height.toString(),
                keyboardType: TextInputType.number,
              ),
              DateField(
                  onSavedCallback: (value) => widget.patient.birthDate = value,
                  currentFocus: birthdateFocus,
                  initialValue: widget.patient.birthDate),
              PersonalDataButton(formKey: _formkey, patient: widget.patient)
            ],
          ),
        ),
      ),
    );
  }
}
