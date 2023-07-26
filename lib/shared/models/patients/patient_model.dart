import 'package:cloud_firestore/cloud_firestore.dart';

class PatientModel {
  String? uid;
  String? name;
  String? email;
  String? gender;
  String? photo;
  DateTime? birthDate;
  double? circumference;
  double? weight;
  double? height;
  double? bmi; // IMC (Indice de massa corporea)
  double? fastingGlucose; // Glicose em jejum
  double? glucose75g;
  double? glycatedHemoglobin; // Hemoglobina Glicada
  double? cholesterol;
  bool? isSurveyCompleted;

  PatientModel(
      {this.uid,
      this.name,
      this.email,
      this.gender,
      this.photo,
      this.birthDate,
      this.bmi,
      this.cholesterol,
      this.circumference,
      this.fastingGlucose,
      this.glucose75g,
      this.glycatedHemoglobin,
      this.height,
      this.weight,
      this.isSurveyCompleted = false});

  factory PatientModel.fromJSON(Map<String, dynamic> patient) {
    if (patient['nascimento'] is Timestamp) {
      patient['nascimento'] = patient['nascimento'].toDate();
    }

    return PatientModel(
        uid: patient['uid'],
        name: patient['nome'],
        email: patient['email'],
        gender: patient['sexo'],
        photo: patient['foto'],
        birthDate: patient['nascimento'],
        circumference: patient['circunferencia'],
        weight: patient['peso'],
        height: patient['altura'],
        bmi: patient['imc'],
        fastingGlucose: patient['glicoseJejum'],
        glucose75g: patient['glicose75g'],
        glycatedHemoglobin: patient['hemoglobinaGlicolisada'],
        cholesterol: patient['colesterol'],
        isSurveyCompleted: patient['questionario']);
  }

  Map<String, dynamic> toJSON() {
    final json = <String, dynamic>{};
    json.putIfAbsent('uid', () => uid);
    json.putIfAbsent('nome', () => name);
    json.putIfAbsent('email', () => email);
    json.putIfAbsent('sexo', () => gender);
    json.putIfAbsent('foto', () => photo);
    json.putIfAbsent('nascimento', () => birthDate);
    json.putIfAbsent('circunferencia', () => circumference);
    json.putIfAbsent('peso', () => weight);
    json.putIfAbsent('altura', () => height);
    json.putIfAbsent('imc', () => bmi);
    json.putIfAbsent('glicoseJejum', () => fastingGlucose);
    json.putIfAbsent('glicose75g', () => glucose75g);
    json.putIfAbsent('hemoglobinaGlicolisada', () => glycatedHemoglobin);
    json.putIfAbsent('colesterol', () => cholesterol);
    json.putIfAbsent('questionario', () => isSurveyCompleted);

    return json;
  }

  copyWith({
    String? uid,
    String? name,
    String? email,
    String? gender,
    String? photo,
    DateTime? birthDate,
    double? circumference,
    double? weight,
    double? height,
    double? bmi,
    double? fastingGlucose,
    double? glucose75g,
    double? glycatedHemoglobin,
    double? cholesterol,
  }) {
    return PatientModel(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        birthDate: birthDate ?? this.birthDate,
        circumference: circumference ?? this.circumference,
        weight: weight ?? this.weight,
        height: height ?? this.height,
        bmi: bmi ?? this.bmi,
        fastingGlucose: fastingGlucose ?? this.fastingGlucose,
        glucose75g: glucose75g ?? this.glucose75g,
        glycatedHemoglobin: glycatedHemoglobin ?? this.glycatedHemoglobin,
        cholesterol: cholesterol ?? this.cholesterol);
  }

  double calculateBmi({double? weight, double? height}) {
    if (weight != null && height != null) {
      return (weight / (height * height));
    } else {
      return (this.weight! / (this.height! * this.height!));
    }
  }

  double getMaxIdealBmi() => (24.9 * height! * height!);

  double getMinIdealBmi() => (18.5 * height! * height!);

  String getBmiCondition(double bmi) {
    if (bmi < 18.5) {
      return "Magreza";
    } else if (bmi <= 24.9) {
      return "Saudável";
    } else if (bmi <= 29.9) {
      return "Sobrepeso";
    } else if (bmi <= 34.9) {
      return "Obesidade grau I";
    } else if (bmi <= 39.9) {
      return "Obesidade grau II";
    } else if (bmi > 40) {
      return "Obesidade grau III";
    }

    return '';
  }
}
