import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sklite/ensemble/forest.dart';

import '../../../../shared/models/patients/survey_model.dart';

class SurveyFowardButton extends StatefulWidget {
  final PageController pageController;
  final Map<String, double> patientSurvey;
  final int currentIndex;
  const SurveyFowardButton(
      {super.key,
      required this.pageController,
      required this.patientSurvey,
      required this.currentIndex});

  @override
  State<SurveyFowardButton> createState() => _SurveyFowardButtonState();
}

class _SurveyFowardButtonState extends State<SurveyFowardButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (widget.currentIndex == 0) {
          debugPrint(
              "=============> high bp: ${widget.patientSurvey['highBp']}");
          debugPrint(
              "=============> high Chol: ${widget.patientSurvey['highChol']}");
          setState(() {
            widget.pageController.jumpToPage(1);
          });
        } else if (widget.currentIndex == 1) {
          setState(() {
            widget.pageController.jumpToPage(2);
          });
        } else if (widget.currentIndex == 2) {
          setState(() {
            widget.pageController.jumpToPage(3);
          });
        } else if (widget.currentIndex == 3) {
          setState(() {
            widget.pageController.jumpToPage(4);
          });
        } else if (widget.currentIndex == 4) {
          setState(() {
            widget.pageController.jumpToPage(5);
          });
        } else if (widget.currentIndex == 5) {
          setState(() {
            widget.pageController.jumpToPage(6);
          });
        } else if (widget.currentIndex == 6) {
          setState(() {
            widget.pageController.jumpToPage(7);
          });
        } else if (widget.currentIndex == 7) {
          setState(() {
            widget.pageController.jumpToPage(8);
          });
        } else if (widget.currentIndex == 8) {
          setState(() {
            widget.pageController.jumpToPage(9);
          });
        } else if (widget.currentIndex == 9) {
          rootBundle
              .loadString('assets/machinelearning/prediabetesmodel.json')
              .then((response) {
            debugPrint('-------tem arquivo ${response.length}');
            // x index : 'GenHlth','HighBP', 'HighChol', 'BMI',
            //'Income', 'DiffWalk', 'Age', 'PhysHlth', 'Education',
            // 'HeartDiseaseorAttack', 'PhysActivity', 'MentHlth',
            //'CholCheck',
            /* var x = [
              1.0,
              0.0,
              1.0,
              32.0,
              5.0,
              0.0,
              5.0,
              0.0,
              6.0,
              0.0,
              0.0,
              3.0,
              1.0,
            ];*/
            final patientSurveyModel = SurveyModel(
                highBP: widget.patientSurvey['highBp'],
                highChol: widget.patientSurvey['highChol'],
                cholCheck: widget.patientSurvey['cholCheck'],
                heartDiseaseorAttack:
                    widget.patientSurvey['heartDiseaseorAttack'],
                genHlth: widget.patientSurvey['genHlth'],
                diffWalk: widget.patientSurvey['diffWalk'],
                physActivity: widget.patientSurvey['physActivity'],
                physHlth: widget.patientSurvey['physHlth'],
                education: widget.patientSurvey['education'],
                income: widget.patientSurvey['income']);
            var x = [
              patientSurveyModel.genHlth!,
              patientSurveyModel.highBP!,
              patientSurveyModel.highChol!,
              patientSurveyModel.bmi!,
              patientSurveyModel.income!,
              patientSurveyModel.diffWalk!,
              patientSurveyModel.age!,
              patientSurveyModel.physHlth!,
              patientSurveyModel.education!,
              patientSurveyModel.heartDiseaseorAttack!,
              patientSurveyModel.physActivity!,
              patientSurveyModel.mentHlth!,
              patientSurveyModel.cholCheck!
            ];
            Map<String, dynamic> params = json.decode(response);
            debugPrint("Loading.......");
            RandomForestClassifier randForest =
                RandomForestClassifier.fromMap(params);
            debugPrint("-----> resultado do modelo: ${randForest.predict(x)}");
          });
          Navigator.pop(context);
        }
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(328, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        widget.currentIndex == 9 ? "Finalizar questionário" : "Próximo",
      ),
    );
  }
}
