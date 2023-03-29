import 'package:flutter/material.dart';
import 'package:predi_v2/android/widgets/buttons/register_button.dart';
import 'package:predi_v2/android/widgets/fields/personal_data_fields/date_field.dart';
import 'package:predi_v2/android/widgets/fields/personal_data_fields/gender_field.dart';
import 'package:predi_v2/android/widgets/fields/login_fields/email_field.dart';

import '../../shared/models/patients/patient_model.dart';
import '../widgets/fields/default_field.dart';
import '../widgets/fields/login_fields/password_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();
  final _loginInfo = <String, String>{};
  final patient = PatientModel(gender: 'Masculino');

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final nameFocus = FocusNode();
  final birthdateFocus = FocusNode();
  final genderFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: const Text('Cadastro'),
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
              const Text(
                'Informações de login',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              EmailField(
                onSavedCallback: (value) => _loginInfo['email'] = value!,
                currentFocus: emailFocus,
                nextFocus: passwordFocus,
              ),
              PasswordField(
                onSavedCallback: (value) => _loginInfo['password'] = value!,
                currentFocus: passwordFocus,
                nextFocus: nameFocus,
              ),
              const Divider(
                thickness: 3.0,
              ),
              const Text('Dados Pessoais',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              DefaultField(
                labelText: 'Nome',
                prefixIcon: Icons.person_2_outlined,
                onSavedCallback: (value) => patient.name = value,
                currentFocus: nameFocus,
                nextFocus: birthdateFocus,
              ),
              DateField(
                  onSavedCallback: (value) => patient.birthDate = value,
                  currentFocus: birthdateFocus),
              GenderField(onSaveCallback: (value) => patient.gender = value),
              RegisterButton(
                  formKey: _formkey, loginInfo: _loginInfo, patient: patient)
            ],
          ),
        ),
      ),
    );
  }
}
