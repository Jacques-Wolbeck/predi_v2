import 'package:flutter/material.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

import '../../widgets/buttons/update_buttons/personal_data_button.dart';
import '../../widgets/fields/default_field.dart';
import '../../widgets/fields/personal_data_fields/date_field.dart';
import '../../widgets/fields/personal_data_fields/gender_field.dart';

// This screen serves to complete google login user data, because they dont have birthdate, height and gender, when they are created
class CompletePersonalDataScreen extends StatefulWidget {
  final PatientModel patient;
  const CompletePersonalDataScreen({super.key, required this.patient});

  @override
  State<CompletePersonalDataScreen> createState() =>
      _CompletePersonalDataScreenState();
}

class _CompletePersonalDataScreenState
    extends State<CompletePersonalDataScreen> {
  final _formkey = GlobalKey<FormState>();
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
              const Text('Complete seus dados pessoais',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              DefaultField(
                labelText: 'Altura',
                prefixIcon: Icons.height,
                onSavedCallback: (value) =>
                    widget.patient.height = double.parse(value!),
                currentFocus: heightFocus,
                nextFocus: birthdateFocus,
                keyboardType: TextInputType.number,
              ),
              DateField(
                  onSavedCallback: (value) => widget.patient.birthDate = value,
                  currentFocus: birthdateFocus),
              GenderField(
                  onSaveCallback: (value) => widget.patient.gender = value),
              PersonalDataButton(formKey: _formkey)
            ],
          ),
        ),
      ),
    );
  }
}
