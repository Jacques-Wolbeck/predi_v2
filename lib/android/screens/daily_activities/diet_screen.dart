import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

class DietScreen extends StatelessWidget {
  final PatientModel patient;

  const DietScreen({super.key, required this.patient});

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
      minimum: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Dicas de uma Dieta Equilibrada',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:
                          Theme.of(context).textTheme.bodyLarge!.fontSize),
                ),
              ),
              _tipOne(context),
              const Divider(),
              _defaultRichText(context, 'Dica 2: ',
                  'Dedique pelo menos 20 minutos para cada refeição, pois esse é o tempo que leva para o cérebro entender que estamos saciados. Mastigue bem!'),
              const Divider(),
              _defaultRichText(context, 'Dica 3: ',
                  'Tenha um tempo para o preparo de suas refeições e congele porções extras de comida saudável para comer nos dias que você está muito ocupado ou fora de casa. Diminua sal e temperos industrializados no preparo de suas refeições. Prefira temperos naturais, como: coentro, salsinha, cebolinha, páprica, açafrão, pimenta do reino.'),
              const Divider(),
              _defaultRichText(context, 'Dica 4: ',
                  'Reduza o consumo de gorduras, como manteiga, margarina, banha de porco e frituras. Prefira consumir gorduras boas, presentes em peixes, abacate, castanha, amendoim, azeite.'),
              const Divider(),
              _defaultRichText(context, 'Dica 5: ',
                  'Desembale menos e descasque mais! Inclua até 3 porções de frutas por dia entre as refeições e associe ao consumo de fibras, como aveia, linhaça, chia, farelo de maracujá.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tipOne(BuildContext context) {
    return Column(
      children: [
        _defaultRichText(context, 'Dica 1: ',
            'Coma em pratos menores e preste atenção no tamanho das porções;'),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 200.0,
          width: 200.0,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  radius: 100.0,
                  color: Colors.red.withOpacity(.5),
                  title: 'Proteína',
                  value: 25,
                  titlePositionPercentageOffset: .6,
                ),
                PieChartSectionData(
                  radius: 100.0,
                  color: Colors.green.withOpacity(.5),
                  title: 'Vegetais',
                  value: 25,
                  titlePositionPercentageOffset: .6,
                ),
                PieChartSectionData(
                  radius: 100.0,
                  color: Colors.orange.withOpacity(.5),
                  title: 'Frutas',
                  value: 25,
                  titlePositionPercentageOffset: .6,
                ),
                PieChartSectionData(
                  radius: 100.0,
                  color: Colors.yellow.withOpacity(.5),
                  title: 'Grãos',
                  value: 25,
                  titlePositionPercentageOffset: .6,
                ),
              ],
            ),
          ),
        ),
        const ListBody(
          children: <Widget>[
            ListTile(
              minVerticalPadding: 1.0,
              leading: Icon(Icons.circle, size: 10.0),
              title: Text(
                '½ do prato: frutas e vegetais',
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            ListTile(
              minVerticalPadding: 1.0,
              leading: Icon(Icons.circle, size: 10.0),
              title: Text('¼ : proteínas magras (frango, carne, ovo e peixe)',
                  style: TextStyle(fontSize: 14.0)),
            ),
            ListTile(
              minVerticalPadding: 1.0,
              leading: Icon(Icons.circle, size: 10.0),
              title: Text('¼ : grãos integrais (arroz ou macarrão)',
                  style: TextStyle(fontSize: 14.0)),
            ),
            ListTile(
              minVerticalPadding: 1.0,
              leading: Icon(Icons.circle, size: 10.0),
              title: Text(
                  '*Evite massas, como pães, biscoitos, macarrão, pizzas, tortas e farinhas brancas.',
                  style: TextStyle(fontSize: 14.0)),
            ),
          ],
        )
      ],
    );
  }

  Widget _defaultRichText(BuildContext context, String str1, String str2) {
    return RichText(
      text: TextSpan(
          text: str1,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
          children: <TextSpan>[
            TextSpan(
              text: str2,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w400),
            )
          ]),
    );
  }
}
