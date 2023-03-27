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

  PatientModel({
    this.uid,
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
  });

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
        cholesterol: patient['colesterol']);
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

    return json;
  }

  copyWith(
      {String? uid,
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
      double? cholesterol}) {
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
}
