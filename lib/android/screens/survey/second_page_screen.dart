import 'package:flutter/material.dart';

import '../../../shared/models/enums/survey_content_enum.dart';
import '../../widgets/buttons/survey_buttons/survey_drop_down_button.dart';

class SecondPageScreen extends StatefulWidget {
  final Function(SurveyContentEnum, dynamic) updateSurvey;
  const SecondPageScreen({super.key, required this.updateSurvey});

  @override
  State<SecondPageScreen> createState() => _SecondPageScreenState();
}

class _SecondPageScreenState extends State<SecondPageScreen> {
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
                  SurveyContentEnum.genHlth.description,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset(
                SurveyContentEnum.genHlth.image,
                height: 30.0,
                width: 30.0,
              )
            ],
          ),
          const SizedBox(height: 16.0),
          SurveyDropDownButton(
              content: SurveyContentEnum.genHlth,
              updateSurvey: widget.updateSurvey)
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
                  SurveyContentEnum.physHlth.description,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset(
                SurveyContentEnum.physHlth.image,
                height: 30.0,
                width: 30.0,
              )
            ],
          ),
          SurveyDropDownButton(
              content: SurveyContentEnum.physHlth,
              updateSurvey: widget.updateSurvey)
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
                  SurveyContentEnum.physActivity.description,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset(
                SurveyContentEnum.physActivity.image,
                height: 30.0,
                width: 30.0,
              )
            ],
          ),
          SurveyDropDownButton(
              content: SurveyContentEnum.physActivity,
              updateSurvey: widget.updateSurvey)
        ],
      ),
    );
  }
}
