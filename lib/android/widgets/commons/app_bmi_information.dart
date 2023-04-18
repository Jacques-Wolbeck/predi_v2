import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/android/widgets/commons/alerts/simple_alert.dart';

import '../../../shared/blocs/authentication/auth_bloc.dart';
import '../../../shared/blocs/authentication/auth_state.dart';
import '../../../shared/blocs/patient/patient_bloc.dart';
import '../../../shared/blocs/patient/patient_event.dart';

class AppBmiInformation extends StatelessWidget {
  const AppBmiInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/imc_icon.png",
            height: 40.0,
            width: 40.0,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 2.0),
          const Text("Qual o meu peso ideal?"),
        ],
      ),
      onTap: () {
        final state = context.read<AuthBloc>().state;
        if (state is Authenticated) {
          if (state.patient.weight != null && state.patient.height != null) {
            final double bmi = (state.patient.weight! /
                (state.patient.height! * state.patient.height!));
            final double minIdealWeight =
                18.5 * state.patient.height! * state.patient.height!;
            final double maxIdealWeight =
                24.9 * state.patient.height! * state.patient.height!;
            final String condition = _bmiCondition(bmi);

            var updatedPatient = state.patient
                .copyWith(bmi: double.parse(bmi.toStringAsPrecision(4)));
            context
                .read<PatientBloc>()
                .add(UpdatePatientRequested(patient: updatedPatient));
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return _alertDialog(
                    context, condition, bmi, maxIdealWeight, minIdealWeight);
              },
            );
          } else {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const SimpleAlert(
                    title: 'Aviso',
                    content:
                        'Informe dados do seu peso e altura, para obter uma estimativa do peso ideal.',
                    button2Text: 'Voltar');
              },
            );
          }
        }
      },
    );
  }

  String _bmiCondition(double bmi) {
    if (bmi < 18.5) {
      return "Magreza";
    } else if (bmi <= 24.9) {
      return "Saudável";
    } else if (bmi <= 29.9) {
      return "Sobrepeso";
    } else if (bmi <= 34.9) {
      return "Obesidade grau I";
    } else if (bmi <= 39.9) {
      return "Obesidade grau II";
    } else if (bmi > 40) {
      return "Obesidade grau III";
    }

    return '';
  }

  Widget _alertDialog(BuildContext context, String condition, double bmi,
      double maxIdealWeight, double minIdealWeight) {
    return AlertDialog(
      title: _title(condition),
      content: _content(bmi, condition, minIdealWeight, maxIdealWeight),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Voltar",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget _title(String condition) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            condition,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          const Icon(Icons.access_alarm),
          const SizedBox(height: 8.0),
          const Text(
            "Peso Ideal",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ]);
  }

  Widget _content(double bmi, String condition, double minIdealWeight,
      double maxIdealWeight) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Seu Índice de Massa Corporal é de ${bmi.toStringAsPrecision(4)}.",
            style: const TextStyle(),
          ),
          Text(
            "Esse valor o coloca em uma faixa considerada como: $condition.",
            style: const TextStyle(),
          ),
          Text(
            "Portanto, estima-se que seu peso ideal se encontra na faixa entre ${minIdealWeight.toStringAsPrecision(4)} kg e ${maxIdealWeight.toStringAsPrecision(4)} kg.",
            style: const TextStyle(),
          )
        ]);
  }
}
