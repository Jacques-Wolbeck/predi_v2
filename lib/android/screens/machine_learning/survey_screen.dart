import 'dart:io';

import 'package:flutter/material.dart';
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

class _SurveyScreenState extends State<SurveyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController(initialPage: 0);
  final patientSurvey = SurveyModel();
  int currentIndex = 0;

  final slideList = [
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
  ];

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
            ),
          ),
          actions: [
            currentIndex == 5
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
                itemCount: slideList.length,
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    slideList[index].image,
                  );
                }),
          ),
          Container(
            //height: size.height * .09,
            padding: EdgeInsets.only(
                left: size.width * .05,
                right: size.width * .05,
                top: size.height * .03),
            child: Column(
              children: [
                Text(
                  slideList[currentIndex].title,
                ),
                SizedBox(height: size.height * .01),
                Text(
                  slideList[currentIndex].description,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
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
                      for (int i = 0; i < slideList.length; i++)
                        if (i == currentIndex)
                          _slideDots(true)
                        else
                          _slideDots(false)
                    ]),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              _forwardButton(),
              _backButton(),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .01,
          ),
        ],
      ),
    );
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

  Widget _forwardButton() {
    return ElevatedButton(
      onPressed: () async {
        if (currentIndex == 0) {
          setState(() {
            _pageController.jumpToPage(1);
          });
        } else if (currentIndex == 1) {
          setState(() {
            _pageController.jumpToPage(2);
          });
        } else if (currentIndex == 2) {
          setState(() {
            _pageController.jumpToPage(3);
          });
        } else if (currentIndex == 3) {
          setState(() {
            _pageController.jumpToPage(4);
          });
        } else if (currentIndex == 4) {
          setState(() {
            _pageController.jumpToPage(5);
          });
        } else if (currentIndex == 5) {
          setState(() {
            _pageController.jumpToPage(6);
          });
        } else if (currentIndex == 6) {
          setState(() {
            _pageController.jumpToPage(7);
          });
        } else if (currentIndex == 7) {
          setState(() {
            _pageController.jumpToPage(8);
          });
        } else if (currentIndex == 8) {
          setState(() {
            _pageController.jumpToPage(9);
          });
        } else if (currentIndex == 9) {
          rootBundle
              .loadString('assets/machine_learning/prediabetes_model.json')
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
            var x = [
              patientSurvey.genHlth!,
              patientSurvey.highBP!,
              patientSurvey.highChol!,
              patientSurvey.bmi!,
              patientSurvey.income!,
              patientSurvey.diffWalk!,
              patientSurvey.age!,
              patientSurvey.physHlth!,
              patientSurvey.education!,
              patientSurvey.heartDiseaseorAttack!,
              patientSurvey.physActivity!,
              patientSurvey.mentHlth!,
              patientSurvey.cholCheck!
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
        currentIndex == 9 ? "Finalizar questionário" : "Próximo",
      ),
    );
  }

  Widget _backButton() {
    return currentIndex > 0
        ? ElevatedButton(
            onPressed: () async {
              if (currentIndex == 1) {
                setState(() {
                  _pageController.jumpToPage(0);
                });
              } else if (currentIndex == 2) {
                setState(() {
                  _pageController.jumpToPage(1);
                });
              } else if (currentIndex == 3) {
                setState(() {
                  _pageController.jumpToPage(2);
                });
              } else if (currentIndex == 4) {
                setState(() {
                  _pageController.jumpToPage(3);
                });
              } else if (currentIndex == 5) {
                setState(() {
                  _pageController.jumpToPage(4);
                });
              } else if (currentIndex == 6) {
                setState(() {
                  _pageController.jumpToPage(5);
                });
              } else if (currentIndex == 7) {
                setState(() {
                  _pageController.jumpToPage(6);
                });
              } else if (currentIndex == 8) {
                setState(() {
                  _pageController.jumpToPage(7);
                });
              } else if (currentIndex == 9) {
                setState(() {
                  _pageController.jumpToPage(8);
                });
              } else if (currentIndex == 10) {
                setState(() {
                  _pageController.jumpToPage(9);
                });
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              minimumSize: const Size(328, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text(
              "Voltar",
            ),
          )
        : const SizedBox.shrink();
  }
}

// TODO o pacote Sklite n tem null safety, entao para rodor o aplicativo é
// necessário utilizar "flutter run --no-sound-null-safety"

//o problema do pacote sklearn, é q o fromMap() de cada modelo estava usando _classes, mas o certo é classes, ficava dando null antes
