import 'package:flutter/material.dart';
import 'package:predi_v2/android/widgets/buttons/survey_buttons/survey_binary_button.dart';

import '../../../shared/models/enums/survey_content_enum.dart';

class FirstPageScreen extends StatefulWidget {
  final Function(SurveyContentEnum, dynamic) updateSurvey;
  const FirstPageScreen({super.key, required this.updateSurvey});

  @override
  State<FirstPageScreen> createState() => _FirstPageScreenState();
}

class _FirstPageScreenState extends State<FirstPageScreen> {
  final List<bool> _selectedBpOption = <bool>[false, true];
  final List<bool> _selectedCholOption = <bool>[false, true];
  final List<bool> _selectedHeartDiseaseOption = <bool>[false, true];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_firstQuestion(), _secondQuestion(), _thirdQuestion()],
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
            SurveyContentEnum.highBp.description,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          SurveyBinaryButton(
            selectedOption: _selectedBpOption,
            onPressed: (index) {
              setState(() {
                for (int i = 0; i < _selectedBpOption.length; i++) {
                  if (i == index) {
                    _selectedBpOption[i] = true;
                  } else {
                    _selectedBpOption[i] = false;
                  }
                }
              });
              if (_selectedBpOption[0]) {
                widget.updateSurvey(SurveyContentEnum.highBp, 1);
              } else {
                widget.updateSurvey(SurveyContentEnum.highBp, 0);
              }
            },
            children: const [Text('Sim'), Text('Não')],
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
            SurveyContentEnum.highChol.description,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          SurveyBinaryButton(
            selectedOption: _selectedCholOption,
            onPressed: (index) {
              setState(() {
                for (int i = 0; i < _selectedCholOption.length; i++) {
                  if (i == index) {
                    _selectedCholOption[i] = true;
                  } else {
                    _selectedCholOption[i] = false;
                  }
                }
              });
              if (_selectedCholOption[0]) {
                widget.updateSurvey(SurveyContentEnum.highChol, 1);
              } else {
                widget.updateSurvey(SurveyContentEnum.highChol, 0);
              }
            },
            children: const [Text('Sim'), Text('Não')],
          )
        ],
      ),
    );
  }

  Widget _thirdQuestion() {
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
            SurveyContentEnum.heartDiseaseorAttack.description,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          SurveyBinaryButton(
            selectedOption: _selectedHeartDiseaseOption,
            onPressed: (index) {
              setState(() {
                for (int i = 0; i < _selectedHeartDiseaseOption.length; i++) {
                  if (i == index) {
                    _selectedHeartDiseaseOption[i] = true;
                  } else {
                    _selectedHeartDiseaseOption[i] = false;
                  }
                }
              });
              if (_selectedHeartDiseaseOption[0]) {
                widget.updateSurvey(SurveyContentEnum.heartDiseaseorAttack, 1);
              } else {
                widget.updateSurvey(SurveyContentEnum.heartDiseaseorAttack, 0);
              }
            },
            children: const [Text('Sim'), Text('Não')],
          )
        ],
      ),
    );
  }
}
