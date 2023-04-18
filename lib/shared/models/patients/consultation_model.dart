import 'package:cloud_firestore/cloud_firestore.dart';

class ConsultationModel {
  String? uid;
  DateTime? date;
  String? examType;
  String? local;

  ConsultationModel({this.uid, this.date, this.examType, this.local});

  factory ConsultationModel.fromJSON(Map<String, dynamic> consultation) {
    if (consultation['date'] is Timestamp) {
      consultation['date'] = consultation['date'].toDate();
    }

    return ConsultationModel(
      uid: consultation['id'],
      date: consultation['date'],
      examType: consultation['titulo'],
      local: consultation['local'],
    );
  }

  Map<String, dynamic> toJSON() {
    final json = <String, dynamic>{};
    json.putIfAbsent('id', () => uid);
    json.putIfAbsent('date', () => date);
    json.putIfAbsent('titulo', () => examType);
    json.putIfAbsent('local', () => local);

    return json;
  }

  copyWith({String? uid, DateTime? date, String? examType, String? local}) {
    return ConsultationModel(
      uid: uid ?? this.uid,
      date: date ?? this.date,
      examType: examType ?? this.examType,
      local: local ?? this.local,
    );
  }
}
