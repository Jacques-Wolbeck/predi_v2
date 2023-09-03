import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/android/widgets/alerts/simple_alert.dart';

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
            "assets/images/icons/imc_icon.png",
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
            final double bmi = state.patient.calculateBmi();
            final double minIdealWeight = state.patient.getMinIdealBmi();
            final double maxIdealWeight = state.patient.getMaxIdealBmi();
            final String condition = state.patient.getBmiCondition(bmi);

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

  Widget _alertDialog(BuildContext context, String condition, double bmi,
      double maxIdealWeight, double minIdealWeight) {
    return AlertDialog(
      iconPadding: EdgeInsets.zero,
      icon: _title(context, condition),
      title: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          "Peso Ideal",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      content: _content(bmi, condition, minIdealWeight, maxIdealWeight),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.keyboard_return_outlined),
              SizedBox(width: 4.0),
              Text('Voltar', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _title(BuildContext context, String condition) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            condition,
            style: Theme.of(context).textTheme.headlineSmall!.merge(
                  TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
          ),
          const SizedBox(height: 8.0),
          Image.asset(
            'assets/images/icons/bmi_icon.png',
            color: Theme.of(context).colorScheme.onPrimary,
            height: 45.0,
            width: 45.0,
          )
        ],
      ),
    );
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
