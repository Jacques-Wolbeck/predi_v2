import 'dart:io';

import 'package:flutter/material.dart';
import 'package:predi_v2/android/screens/machine_learning/first_question_screen.dart';
import 'package:predi_v2/android/widgets/buttons/survey_buttons/survey_back_button.dart';
import 'package:predi_v2/android/widgets/buttons/survey_buttons/survey_foward_button.dart';
import 'package:predi_v2/android/widgets/fields/default_field.dart';
import 'package:predi_v2/shared/models/enums/survey_content_enum.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

import 'package:sklite/ensemble/forest.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

import '../../../shared/models/patients/survey_model.dart';

class SurveyScreen extends StatefulWidget {
  final PatientModel patient;
  const SurveyScreen({super.key, required this.patient});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

//TODO o aplicativo fica muito pesado com json de modelo de aprendizagem de maquina
class _SurveyScreenState extends State<SurveyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController(initialPage: 0);
  final Map<String, double> patientSurvey = {
    'highBp': 0.0,
    'highChol': 0.0,
    'cholCheck': 0.0,
    'heartDiseaseorAttack': 0.0,
    'genHlth': 0.0,
    'diffWalk': 0.0,
    'physActivity': 0.0,
    'physHlth': 0.0,
    'education': 0.0,
    'income': 0.0,
  };
  int currentIndex = 0;

  /*final slideList = [
    SurveyContentEnum.highBp,
    SurveyContentEnum.highChol,
    SurveyContentEnum.cholCheck,
    SurveyContentEnum.heartDiseaseorAttack,
    SurveyContentEnum.genHlth,
    SurveyContentEnum.diffWalk,
    SurveyContentEnum.physActivity,
    SurveyContentEnum.physHlth,
    SurveyContentEnum.education,
    SurveyContentEnum.income
  ];*/

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
            currentIndex == 9
                ? const SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.only(
                        right: size.width * .05, top: size.height * .01),
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
        body: _body(size));
  }

  Widget _body(Size size) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .4,
              width: size.width,
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                  left: size.width * .08, right: size.width * .08),
              child: PageView.builder(
                  itemCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return _getSlide(index);
                  }),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .08,
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        for (int i = 0; i < 2; i++)
                          if (i == currentIndex)
                            _slideDots(true)
                          else
                            _slideDots(false)
                      ]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                SurveyFowardButton(
                    pageController: _pageController,
                    patientSurvey: patientSurvey,
                    currentIndex: currentIndex),
                SurveyBackButton(
                    pageController: _pageController, currentIndex: currentIndex)
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
          ],
        ),
      ),
    );
  }

  void _updateMap(String key, double newValue) {
    patientSurvey.update(key, (value) => newValue);
  }

  Widget _getSlide(int index) {
    switch (index) {
      case 0:
        return FirstQuestionScreen(updateSurvey: _updateMap);
      case 1:
        return FirstQuestionScreen(updateSurvey: _updateMap);
      default:
        return FirstQuestionScreen(updateSurvey: _updateMap);
    }
  }

  Widget _slideDots(bool isEnable) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      height: isEnable ? 8.0 : 7.0,
      width: isEnable ? 8.0 : 7.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isEnable
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

// TODO o pacote Sklite n tem null safety, entao para rodor o aplicativo é
// necessário utilizar "flutter run --no-sound-null-safety"

//o problema do pacote sklearn, é q o fromMap() de cada modelo estava usando _classes, mas o certo é classes, ficava dando null antes
