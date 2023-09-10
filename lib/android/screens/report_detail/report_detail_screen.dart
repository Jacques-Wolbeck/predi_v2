import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:predi_v2/shared/models/enums/survey_content_enum.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';
import 'package:predi_v2/shared/models/patients/survey_model.dart';

class ReportDetailScreen extends StatelessWidget {
  final PatientModel patient;
  final SurveyModel surveyData;

  const ReportDetailScreen(
      {super.key, required this.patient, required this.surveyData});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        leading: Padding(
          padding: EdgeInsets.only(
            left: size.width * .05,
            right: size.width * .01,
            top: size.height * .01,
          ),
          child: Image.asset(
            'assets/images/heart.png',
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
                right: size.width * .05, top: size.height * .01),
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Voltar',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Detalhes do Relatório',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize),
              ),
            ),
            Column(
              children: [
                surveyData.physActivity == 1
                    ? const SizedBox.shrink()
                    : _defaultContainer(
                        context,
                        SurveyContentEnum.physActivity.title,
                        const Text(
                            'Sua condição atual demonstra que há uma falta de exercicios, é necessário uma melhora neste quesito.'),
                        'Comece caminhando 5 a 10 minutos nos primeiros dias. Depois, adicione mais tempo de forma progressiva até alcançar pelo menos 30 minutos por dia, 5 vezes por semana. Mesmo sem perder peso, fazer atividades físicas ajuda a prevenir ou pelo menos retardar o diabetes e você pode se exercitar mesmo dentro de casaMesmo sem perder peso, fazer atividades físicas ajuda a prevenir ou pelo menos retardar odiabetes e você pode se exercitar mesmo dentro de casa.'),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Widget _defaultContainer(
      BuildContext context, String title, Widget content, String tip) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              blurRadius: .2,
              offset: const Offset(.5, .5),
              color: Theme.of(context).colorScheme.shadow,
            )
          ]),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          content,
          const SizedBox(height: 8.0),
          Text(tip),
        ],
      ),
    );
  }
}
