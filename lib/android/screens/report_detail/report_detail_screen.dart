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
                (surveyData.physActivity == 1)
                    ? const SizedBox.shrink()
                    : _defaultContainer(
                        context,
                        SurveyContentEnum.physActivity.title,
                        'Sua condição atual demonstra que há uma falta de exercicios, é necessária uma melhora neste quesito.',
                        'Comece aos poucos!',
                        const Text(
                            'Comece caminhando 5 a 10 minutos nos primeiros dias. Depois, adicione mais tempo de forma progressiva até alcançar pelo menos 30 minutos por dia, 5 vezes por semana. Mesmo sem perder peso, fazer atividades físicas ajudam a prevenir ou pelo menos retardar o diabetes e você pode se exercitar até mesmo dentro de casa.'),
                      ),
                (patient.bmi! < 25.0)
                    ? const SizedBox.shrink()
                    : _defaultContainer(
                        context,
                        SurveyContentEnum.bmi.title,
                        'Seu Índice de Massa Corporal (IMC) apresenta um valor acima do ideal, logo são necessárias medidas para reduzir seu peso corporal.',
                        'Recomenda-se',
                        ListBody(
                          children: [
                            Text(
                                'Procurar um profissional de saúde para auxiliá-lo na sua adequação de peso, pois você se encontra em um estágio de ${patient.getBmiCondition(patient.bmi!)}. Seu IMC é de ${patient.bmi.toString()}, estima-se que seu peso ideal se encontra na faixa entre ${patient.getMinIdealBmi().toStringAsPrecision(4)} kg e ${patient.getMaxIdealBmi().toStringAsPrecision(4)} kg.'),
                            const Divider(),
                            Text(
                                'Sua taxa metabólica basal é de: ${patient.calculateBasalMetabolicRate().toStringAsFixed(2)} Kcal. Portanto, para a perda de peso é necessário adotar uma dieta onde se consuma menos calorias que seu gasto energético, incentivando o organismo a obter energia através da queima da gordura acumulada.')
                          ],
                        ),
                      ),
                (surveyData.smoker == 0)
                    ? const SizedBox.shrink()
                    : _defaultContainer(
                        context,
                        SurveyContentEnum.smoker.title,
                        'Se ainda não parou, recomenda-se parar o consumo de cigarros. Fumar cigarros todos os dias está relacionado a um maior risco de desenvolver Diabetes Mellitus tipo 2 no longo prazo, e isso pode ser explicado, em parte, pelo impacto da nicotina na sensibilidade à insulina.',
                        'Parada Gradual!',
                        const ListBody(
                          children: [
                            Text(
                                'Um metodo eficiente para parar de fumar, consiste em ir reduzindo o número de cigarros consumidos a cada dia. Por exemplo: '),
                            SizedBox(height: 8),
                            Text('Um fumante que consome 30 cigarros por dia.'),
                            Text(
                                ' - no primeiro dia fuma os 30 cigarros usuais;'),
                            Text(' - no segundo 25 cigarros;'),
                            Text(' - no terceiro 20 cigarros;'),
                            Text(' - no quarto 15 cigarros;'),
                            Text(' - no quinto 10 cigarros;'),
                            Text(' - no sexto 5 cigarros;'),
                            Text(
                                'O sétimo dia seria a data para deixar de fumar.')
                          ],
                        ),
                      ),
                !(surveyData.fruits == 0 || surveyData.veggies == 0)
                    ? const SizedBox.shrink()
                    : _defaultContainer(
                        context,
                        'Alimentos',
                        'A fim de diminuir o risco de desenvolver o Diabetes Mellitus tipo 2, é aconselhável o consumo de alimentos provenientes da natureza, tais como cereais integrais, vegetais, frutas e legumes.',
                        'Indica-se',
                        Table(
                          border: TableBorder(
                            horizontalInside: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                            verticalInside: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                          ),
                          children: [
                            _createTableRow("Cereais, Frutas, Vegetais"),
                            _createTableRow("arroz integral, goiaba , couve "),
                            _createTableRow("quinoa, abacaxi, alface"),
                            _createTableRow("milho, limão, espinafre"),
                            _createTableRow("aveia, morango, brócolis"),
                            _createTableRow("trigo integral, abacate, rúcula"),
                            _createTableRow("-, pêssego, couve-flor"),
                          ],
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Widget _defaultContainer(BuildContext context, String title, String content,
      String tipTitle, Widget tip) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8.0),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0)),
            ),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                const SizedBox(height: 8.0),
                Text(
                  content,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(tipTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 8.0),
                tip,
              ],
            ),
          ),
        ],
      ),
    );
  }

  _createTableRow(String listNames) {
    return TableRow(
      children: listNames.split(',').map((name) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
          ),
        );
      }).toList(),
    );
  }
}
