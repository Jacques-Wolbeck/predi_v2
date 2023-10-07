import 'package:cloud_firestore/cloud_firestore.dart';

class RateModel {
  String? uid;
  DateTime? date; // IMC (Indice de massa corporea)
  double? fastingGlucose; // Glicose em jejum
  double? glucose75g;
  double? glycatedHemoglobin; // Hemoglobina Glicada
  double? cholesterol;

  RateModel({
    this.uid,
    this.date,
    this.cholesterol,
    this.fastingGlucose,
    this.glucose75g,
    this.glycatedHemoglobin,
  });

  factory RateModel.fromJSON(Map<String, dynamic> rate) {
    if (rate['dateTaxas'] is Timestamp) {
      rate['dateTaxas'] = rate['dateTaxas'].toDate();
    }

    return RateModel(
        uid: rate['id'],
        date: rate['dateTaxas'],
        fastingGlucose: rate['glicoseJejum'],
        glucose75g: rate['glicose75g'],
        glycatedHemoglobin: rate['hemoglobinaGlico'],
        cholesterol: rate['colesterol']);
  }

  Map<String, dynamic> toJSON() {
    final json = <String, dynamic>{};
    json.putIfAbsent('id', () => uid);
    json.putIfAbsent('dateTaxas', () => date);
    json.putIfAbsent('glicoseJejum', () => fastingGlucose);
    json.putIfAbsent('glicose75g', () => glucose75g);
    json.putIfAbsent('hemoglobinaGlico', () => glycatedHemoglobin);
    json.putIfAbsent('colesterol', () => cholesterol);

    return json;
  }

  copyWith(
      {String? uid,
      DateTime? date,
      double? fastingGlucose,
      double? glucose75g,
      double? glycatedHemoglobin,
      double? cholesterol}) {
    return RateModel(
        uid: uid ?? this.uid,
        date: date ?? this.date,
        fastingGlucose: fastingGlucose ?? this.fastingGlucose,
        glucose75g: glucose75g ?? this.glucose75g,
        glycatedHemoglobin: glycatedHemoglobin ?? this.glycatedHemoglobin,
        cholesterol: cholesterol ?? this.cholesterol);
  }
}
