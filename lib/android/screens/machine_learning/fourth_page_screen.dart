import 'package:flutter/material.dart';

import '../../../shared/models/enums/survey_content_enum.dart';

class FourthPageScreen extends StatefulWidget {
  final Function(String, double) updateSurvey;
  const FourthPageScreen({super.key, required this.updateSurvey});

  @override
  State<FourthPageScreen> createState() => _FourthPageScreenState();
}

class _FourthPageScreenState extends State<FourthPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _firstQuestion(),
        _secondQuestion(),
      ],
    );
  }

  Widget _firstQuestion() {
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
            SurveyContentEnum.physHlth.description,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              double doubleValue = double.parse(value!);
              if (doubleValue > 30 || doubleValue < 0) {
                return 'Valor inválido, digite valores entre 0-30';
              }
              return null;
            },
            onFieldSubmitted: (value) {
              widget.updateSurvey('physHlth', double.parse(value));
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: SurveyContentEnum.physHlth.title,
              hintText: '30.0',
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(width: .8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(width: .8),
              ),
              contentPadding: const EdgeInsets.all(16.0),
            ),
          )
        ],
      ),
    );
  }

  Widget _secondQuestion() {
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
            SurveyContentEnum.mentHlth.description,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              double doubleValue = double.parse(value!);
              if (doubleValue > 30 || doubleValue < 0) {
                return 'Valor inválido, digite valores entre 0-30';
              }
              return null;
            },
            onFieldSubmitted: (value) {
              widget.updateSurvey('mentHlth', double.parse(value));
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: SurveyContentEnum.mentHlth.title,
              hintText: '30.0',
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(width: .8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(width: .8),
              ),
              contentPadding: const EdgeInsets.all(16.0),
            ),
          )
        ],
      ),
    );
  }
}
