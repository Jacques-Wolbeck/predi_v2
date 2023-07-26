import 'package:cloud_firestore/cloud_firestore.dart';

class SurveyModel {
  String? uid;
  DateTime? date;
  int? bmi;
  int? age;
  int? genHlth;
  int? highBP;
  int? highChol;
  int? diffWalk;
  int? physHlth;
  int? education;
  int? heartDiseaseorAttack;
  int? physActivity;

  SurveyModel({
    this.uid,
    this.date,
    this.bmi,
    this.age,
    this.genHlth,
    this.highBP,
    this.highChol,
    this.diffWalk,
    this.physHlth,
    this.education,
    this.heartDiseaseorAttack,
    this.physActivity,
  });

  factory SurveyModel.fromJSON(Map<String, dynamic> survey) {
    if (survey['date_survey'] is Timestamp) {
      survey['date_survey'] = survey['date_survey'].toDate();
    }
    return SurveyModel(
      uid: survey['uid'],
      date: survey['date_survey'],
      bmi: survey['bmi'],
      age: survey['age'],
      genHlth: survey['gen_hlth'],
      highBP: survey['high_bp'],
      highChol: survey['high_chol'],
      diffWalk: survey['diffwalk'],
      physHlth: survey['phys_hlth'],
      physActivity: survey['phys_activity'],
      education: survey['education'],
      heartDiseaseorAttack: survey['heart_disease_or_attack'],
    );
  }
  Map<String, dynamic> toJSON({bool isPredict = false}) {
    if (isPredict) {
      return {
        "gen_hlth": genHlth,
        "high_bp": highBP,
        "high_chol": highChol,
        "bmi": bmi,
        "diffwalk": diffWalk,
        "age": age,
        "phys_hlth": physHlth,
        "education": education,
        "heart_disease_or_attack": heartDiseaseorAttack,
        "phys_activity": physActivity
      };
    } else {
      final json = <String, dynamic>{};
      json.putIfAbsent('uid', () => uid);
      json.putIfAbsent('date_survey', () => date);
      json.putIfAbsent('bmi', () => bmi);
      json.putIfAbsent('age', () => age);
      json.putIfAbsent('gen_hlth', () => genHlth);
      json.putIfAbsent('high_bp', () => highBP);
      json.putIfAbsent('high_chol', () => highChol);
      json.putIfAbsent('diffwalk', () => diffWalk);
      json.putIfAbsent('phys_hlth', () => physHlth);
      json.putIfAbsent('phys_activity', () => physActivity);
      json.putIfAbsent('education', () => education);
      json.putIfAbsent('heart_disease_or_attack', () => heartDiseaseorAttack);
      return json;
    }
  }

  @override
  String toString() {
    return 'uid $uid / date $date';
  }
}
