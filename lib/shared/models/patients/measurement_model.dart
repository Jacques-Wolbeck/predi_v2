import 'package:cloud_firestore/cloud_firestore.dart';

class MeasurementModel {
  String? uid;
  DateTime? date;
  double? weight;
  double? circumference;

  MeasurementModel({this.uid, this.date, this.weight, this.circumference});

  factory MeasurementModel.fromJSON(Map<String, dynamic> measure) {
    if (measure['dateMedida'] is Timestamp) {
      measure['dateMedida'] = measure['dateMedida'].toDate();
    }

    return MeasurementModel(
      uid: measure['id'],
      date: measure['dateMedida'],
      weight: measure['peso'],
      circumference: measure['circunferencia'],
    );
  }

  Map<String, dynamic> toJSON() {
    final json = <String, dynamic>{};
    json.putIfAbsent('id', () => uid);
    json.putIfAbsent('dateMedida', () => date);
    json.putIfAbsent('peso', () => weight);
    json.putIfAbsent('circunferencia', () => circumference);

    return json;
  }

  copyWith(
      {String? uid, DateTime? date, double? weight, double? circumference}) {
    return MeasurementModel(
      uid: uid ?? this.uid,
      date: date ?? this.date,
      weight: weight ?? this.weight,
      circumference: circumference ?? this.circumference,
    );
  }
}
