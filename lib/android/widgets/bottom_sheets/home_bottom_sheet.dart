import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/android/widgets/alerts/simple_alert.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

import '../../../shared/blocs/authentication/auth_bloc.dart';
import '../../../shared/blocs/authentication/auth_event.dart';
import '../commons/app_screen_args.dart';

class HomeBottomSheet extends StatelessWidget {
  final PatientModel patient;
  const HomeBottomSheet({super.key, required this.patient});

  //TODO THE URL OF PHOTO IS NOT UPDATING IN THE FIREBASE DATABASE

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            thickness: 4.0,
            indent: MediaQuery.of(context).size.width * 0.4,
            endIndent: MediaQuery.of(context).size.width * 0.4,
            color: Theme.of(context).colorScheme.primary,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _patientInfo(context),
              _listTiles(
                context,
                "Editar dados gerais",
                Icons.settings,
                () => Navigator.pushNamed(context, '/edit_personal_data_screen',
                    arguments: DefaultScreenArguments(patient: patient)),
              ),
              const Divider(),
              _listTiles(
                context,
                "Sair",
                Icons.exit_to_app,
                () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return SimpleAlert(
                        title: 'Deseja realmente sair?',
                        content: '',
                        button1Text: 'Sim',
                        button2Text: 'Não',
                        onPressed: () {
                          context.read<AuthBloc>().add(SignOutRequested());
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login_screen', (route) => false);
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _listTiles(
      BuildContext context, String text, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          text,
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }

  Widget _patientInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          patient.photo != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(patient.photo!),
                )
              : CircleAvatar(
                  backgroundImage: const AssetImage(
                    "assets/images/icons/patient_icon.png",
                  ),
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                ),
          const SizedBox(height: 12.0),
          Text(
            patient.name!,
            style: Theme.of(context).textTheme.titleMedium!.merge(
                  TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
          ),
          Text(
            patient.email!,
            style: Theme.of(context).textTheme.titleSmall!.merge(
                TextStyle(color: Theme.of(context).colorScheme.secondary)),
          ),
          Text(
            '${patient.height ?? 0.00} m',
            style: Theme.of(context).textTheme.titleSmall!.merge(
                TextStyle(color: Theme.of(context).colorScheme.secondary)),
          ),
        ],
      ),
    );
  }
}
