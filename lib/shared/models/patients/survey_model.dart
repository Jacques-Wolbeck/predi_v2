import 'package:cloud_firestore/cloud_firestore.dart';

class SurveyModel {
  String? uid;
  DateTime? date;
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
    if (survey['dateSurvey'] is Timestamp) {
      survey['dateSurvey'] = survey['dateSurvey'].toDate();
    }
    return SurveyModel(
      uid: survey['uid'],
      date: survey['dateSurvey'],
      age: survey['age'],
      genHlth: survey['genHlth'],
      highBP: survey['highBp'],
      highChol: survey['highChol'],
      diffWalk: survey['diffWalk'],
      physHlth: survey['physHlth'],
      physActivity: survey['physActivity'],
      education: survey['education'],
      heartDiseaseorAttack: survey['heartDiseaseorAttack'],
    );
  }
  Map<String, dynamic> toJSON() {
    final json = <String, dynamic>{};
    json.putIfAbsent('uid', () => uid);
    json.putIfAbsent('dateSurvey', () => date);
    json.putIfAbsent('age', () => age);
    json.putIfAbsent('genHlth', () => genHlth);
    json.putIfAbsent('highBp', () => highBP);
    json.putIfAbsent('highChol', () => highChol);
    json.putIfAbsent('diffWalk', () => diffWalk);
    json.putIfAbsent('physHlth', () => physHlth);
    json.putIfAbsent('physActivity', () => physActivity);
    json.putIfAbsent('education', () => education);
    json.putIfAbsent('heartDiseaseorAttack', () => heartDiseaseorAttack);
    /*return {
      "uid": uid,
      "dateSurvey": date,
      "age": age,
      "genHlth": genHlth.toString(),
      "highBp": highBP.toString(),
      "highChol": highChol.toString(),
      "diffWalk": diffWalk.toString(),
      "physHlth": physHlth.toString(),
      "education": education.toString(),
      "heartDiseaseorAttack": heartDiseaseorAttack.toString(),
      "physActivity": physActivity.toString(),
    };*/
    return json;
  }
}
