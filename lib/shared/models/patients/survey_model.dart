import 'package:cloud_firestore/cloud_firestore.dart';

class SurveyModel {
  String? uid;
  DateTime? date;
  int? bmi;
  int? age;
  int? genHlth;
  int? highBP;
  int? highChol;
  int? physHlth;
  int? education;
  int? physActivity;
  int? smoker;
  int? fruits;
  int? veggies;
  int? sex;

  SurveyModel(
      {this.uid,
      this.date,
      this.bmi,
      this.age,
      this.genHlth,
      this.highBP,
      this.highChol,
      this.physHlth,
      this.education,
      this.physActivity,
      this.fruits,
      this.smoker,
      this.veggies,
      this.sex});

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
        physHlth: survey['phys_hlth'],
        physActivity: survey['phys_activity'],
        education: survey['education'],
        smoker: survey['smoker'],
        fruits: survey['fruits'],
        veggies: survey['veggies'],
        sex: survey['sex']);
  }
  Map<String, dynamic> toJSON({bool isPredict = false}) {
    if (isPredict) {
      return {
        "gen_hlth": genHlth,
        "high_bp": highBP,
        "high_chol": highChol,
        "bmi": bmi,
        "age": age,
        "phys_hlth": physHlth,
        "education": education,
        "phys_activity": physActivity,
        "fruits": fruits,
        "veggies": veggies,
        "smoker": smoker,
        "sex": sex
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
      json.putIfAbsent('phys_hlth', () => physHlth);
      json.putIfAbsent('phys_activity', () => physActivity);
      json.putIfAbsent('education', () => education);
      json.putIfAbsent('smoker', () => smoker);
      json.putIfAbsent('fruits', () => fruits);
      json.putIfAbsent('veggies', () => veggies);
      json.putIfAbsent('sex', () => sex);

      return json;
    }
  }

  @override
  String toString() {
    return 'uid $uid / date $date';
  }
}
