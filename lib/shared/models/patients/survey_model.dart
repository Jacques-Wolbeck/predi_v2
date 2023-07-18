class SurveyModel {
  final int? genHlth;
  final int? highBP;
  final int? highChol;
  final int? bmi;
  final int? income;
  final int? diffWalk;
  final int? age;
  final int? physHlth;
  final int? education;
  final int? heartDiseaseorAttack;
  final int? physActivity;
  final int? mentHlth;
  late final int? cholCheck;

  SurveyModel(
      {this.genHlth,
      this.highBP,
      this.highChol,
      this.bmi,
      this.income,
      this.diffWalk,
      this.age,
      this.physHlth,
      this.education,
      this.heartDiseaseorAttack,
      this.physActivity,
      this.mentHlth,
      this.cholCheck});

  Map<String, dynamic> toJson() {
    return {
      "gen_hlth": genHlth.toString(),
      "high_bp": highBP.toString(),
      "high_chol": highChol.toString(),
      "bmi": bmi.toString(),
      "income": income.toString(),
      "diffwalk": diffWalk.toString(),
      "age": age.toString(),
      "phys_hlth": physHlth.toString(),
      "education": education.toString(),
      "heart_disease_or_attack": heartDiseaseorAttack.toString(),
      "phys_activity": physActivity.toString(),
      "men_hlth": mentHlth.toString(),
      "chol_check": cholCheck.toString()
    };
  }
}
