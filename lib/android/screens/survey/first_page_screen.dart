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
  final List<bool> _selectedSmokerOption = <bool>[false, true];

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  SurveyContentEnum.highBp.description,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset(
                SurveyContentEnum.highBp.image,
                height: 30.0,
                width: 30.0,
              )
            ],
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                SurveyContentEnum.highChol.description,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Image.asset(
                SurveyContentEnum.highChol.image,
                height: 30.0,
                width: 30.0,
              )
            ],
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  SurveyContentEnum.smoker.description,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset(
                SurveyContentEnum.smoker.image,
                height: 30.0,
                width: 30.0,
              )
            ],
          ),
          const SizedBox(height: 16.0),
          SurveyBinaryButton(
            selectedOption: _selectedSmokerOption,
            onPressed: (index) {
              setState(() {
                for (int i = 0; i < _selectedSmokerOption.length; i++) {
                  if (i == index) {
                    _selectedSmokerOption[i] = true;
                  } else {
                    _selectedSmokerOption[i] = false;
                  }
                }
              });
              if (_selectedSmokerOption[0]) {
                widget.updateSurvey(SurveyContentEnum.smoker, 1);
              } else {
                widget.updateSurvey(SurveyContentEnum.smoker, 0);
              }
            },
            children: const [Text('Sim'), Text('Não')],
          )
        ],
      ),
    );
  }
}
