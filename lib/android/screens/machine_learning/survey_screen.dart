import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:predi_v2/android/screens/machine_learning/first_page_screen.dart';
import 'package:predi_v2/android/screens/machine_learning/fourth_page_screen.dart';
import 'package:predi_v2/android/screens/machine_learning/second_page_screen.dart';
import 'package:predi_v2/android/screens/machine_learning/third_page_screen.dart';
import 'package:predi_v2/android/widgets/buttons/survey_buttons/survey_back_button.dart';
import 'package:predi_v2/android/widgets/buttons/survey_buttons/survey_foward_button.dart';

import 'package:predi_v2/shared/models/patients/patient_model.dart';

class SurveyScreen extends StatefulWidget {
  final PatientModel patient;
  const SurveyScreen({super.key, required this.patient});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

//TODO o aplicativo fica muito pesado com json de modelo de aprendizagem de maquina
class _SurveyScreenState extends State<SurveyScreen> {
  final _pageController = PageController(initialPage: 0);
  final Map<String, int> patientSurvey = {
    'highBp': 0,
    'highChol': 0,
    'cholCheck': 0,
    'heartDiseaseorAttack': 0,
    'genHlth': 0,
    'diffWalk': 0,
    'physActivity': 0,
    'physHlth': 0,
    'mentHlth': 0,
    'education': 0,
    'income': 0,
  };
  int currentIndex = 0;

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
          currentIndex == 3
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SurveyFowardButton(
                pageController: _pageController,
                patientSurvey: patientSurvey,
                currentIndex: currentIndex),
            SurveyBackButton(
                pageController: _pageController, currentIndex: currentIndex)
          ],
        ),
      ),
      body: _body(size),
    );
  }

  Widget _body(Size size) {
    return SafeArea(
      child:
          LayoutBuilder(builder: (context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .5,
                      width: size.width,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          left: size.width * .08, right: size.width * .08),
                      child: PageView.builder(
                          itemCount: 4,
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
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .08,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          for (int i = 0; i < 4; i++)
                            if (i == currentIndex)
                              _slideDots(true)
                            else
                              _slideDots(false)
                        ]),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void _updateMap(String key, int newValue) {
    patientSurvey.update(key, (value) => newValue);
  }

  Widget _getSlide(int index) {
    debugPrint('---------> ${patientSurvey.toString()}');
    switch (index) {
      case 0:
        return FirstPageScreen(updateSurvey: _updateMap);
      case 1:
        return SecondPageScreen(updateSurvey: _updateMap);
      case 2:
        return ThirdPageScreen(updateSurvey: _updateMap);
      case 3:
        return FourthPageScreen(updateSurvey: _updateMap);
      default:
        return FirstPageScreen(updateSurvey: _updateMap);
    }
  }

  Widget _slideDots(bool isEnable) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
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
