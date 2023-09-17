import 'package:flutter/material.dart';
import 'package:predi_v2/android/widgets/buttons/survey_buttons/survey_binary_button.dart';
import 'package:predi_v2/android/widgets/buttons/survey_buttons/survey_drop_down_button.dart';

import '../../../shared/models/enums/survey_content_enum.dart';

class ThirdPageScreen extends StatefulWidget {
  final Function(SurveyContentEnum, dynamic) updateSurvey;
  const ThirdPageScreen({super.key, required this.updateSurvey});

  @override
  State<ThirdPageScreen> createState() => _ThirdPageScreenState();
}

class _ThirdPageScreenState extends State<ThirdPageScreen> {
  final List<bool> _selectedFruitsOption = <bool>[false, true];
  final List<bool> _selectedVeggiesOption = <bool>[false, true];
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
                  SurveyContentEnum.fruits.description,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset(
                SurveyContentEnum.fruits.image,
                height: 30.0,
                width: 30.0,
                color: Colors.black,
              )
            ],
          ),
          const SizedBox(height: 16.0),
          SurveyBinaryButton(
            selectedOption: _selectedFruitsOption,
            onPressed: (index) {
              setState(() {
                for (int i = 0; i < _selectedFruitsOption.length; i++) {
                  if (i == index) {
                    _selectedFruitsOption[i] = true;
                  } else {
                    _selectedFruitsOption[i] = false;
                  }
                }
              });
              if (_selectedFruitsOption[0]) {
                widget.updateSurvey(SurveyContentEnum.fruits, 1);
              } else {
                widget.updateSurvey(SurveyContentEnum.fruits, 0);
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
              Expanded(
                child: Text(
                  SurveyContentEnum.veggies.description,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset(
                SurveyContentEnum.veggies.image,
                height: 30.0,
                width: 30.0,
                color: Colors.black,
              )
            ],
          ),
          const SizedBox(height: 16.0),
          SurveyBinaryButton(
            selectedOption: _selectedVeggiesOption,
            onPressed: (index) {
              setState(() {
                for (int i = 0; i < _selectedVeggiesOption.length; i++) {
                  if (i == index) {
                    _selectedVeggiesOption[i] = true;
                  } else {
                    _selectedVeggiesOption[i] = false;
                  }
                }
              });
              if (_selectedVeggiesOption[0]) {
                widget.updateSurvey(SurveyContentEnum.veggies, 1);
              } else {
                widget.updateSurvey(SurveyContentEnum.veggies, 0);
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
                  SurveyContentEnum.education.description,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset(
                SurveyContentEnum.education.image,
                height: 30.0,
                width: 30.0,
              )
            ],
          ),
          SurveyDropDownButton(
            content: SurveyContentEnum.education,
            updateSurvey: widget.updateSurvey,
          ),
        ],
      ),
    );
  }
}
