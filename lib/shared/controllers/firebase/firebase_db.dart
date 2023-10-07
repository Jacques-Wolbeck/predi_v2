import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:predi_v2/shared/models/enums/data_type_enum.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

import '../../models/patients/consultation_model.dart';
import '../../models/patients/measurement_model.dart';
import '../../models/patients/rate_model.dart';
import '../../models/patients/survey_model.dart';
import 'firebase_errors.dart';

class FirebaseDb {
  FirebaseDb._init();
  static final FirebaseDb instance = FirebaseDb._init();
  final _dataReference = FirebaseFirestore.instance.collection('pacientes');

  CollectionReference _getRef(PatientModel patient, DataTypeEnum dataType) {
    return _dataReference
        .doc(patient.uid)
        .collection(dataType.primaryTitle.toLowerCase());
  }

  Future<void> create(PatientModel patient, DataTypeEnum dataType, data) async {
    try {
      final docReference = _getRef(patient, dataType);
      data.uid = docReference.doc().id;
      docReference.doc(data.uid).set(data.toJSON());
    } catch (error) {
      throw FormattedException(
          'Erro ao criar uma nova ${dataType.secondaryTitle}.');
    }
  }

  Future<void> update(PatientModel patient, DataTypeEnum dataType, data) async {
    try {
      final docReference = _getRef(patient, dataType).doc(data.uid);
      await docReference.update(data.toJSON());
    } catch (error) {
      throw FormattedException(
          'Erro ao atualizar a(s) ${dataType.primaryTitle}.');
    }
  }

  Future<void> delete(PatientModel patient, DataTypeEnum dataType,
      List<dynamic> deleteList) async {
    try {
      for (var data in deleteList) {
        final docReference = _getRef(patient, dataType).doc(data.uid);
        await docReference.delete();
      }
    } catch (error) {
      throw FormattedException(
          'Erro ao deleter a(s) ${dataType.primaryTitle}.');
    }
  }

  Stream<List?> getAll(PatientModel patient, DataTypeEnum dataType) {
    return _getRef(patient, dataType)
        .orderBy(_getOrderBy(dataType),
            descending: dataType == DataTypeEnum.consultation ? false : true)
        .snapshots()
        .asyncMap((snapshot) => snapshot.docs
            .map(
              (DocumentSnapshot doc) => _getFromJSON(doc, dataType),
            )
            .toList());
  }

  Future<SurveyModel?> getLastSurvey(PatientModel patient) async {
    try {
      var snapshot = await _getRef(patient, DataTypeEnum.survey).get();
      var doc = snapshot.docs.last;
      return SurveyModel.fromJSON(doc.data() as Map<String, dynamic>);
    } catch (error) {
      throw const FormattedException('Questionário incompleto.');
    }
  }

  Object _getOrderBy(DataTypeEnum dataType) {
    switch (dataType) {
      case (DataTypeEnum.rate):
        return 'dateTaxas';
      case (DataTypeEnum.measure):
        return 'dateMedida';
      case (DataTypeEnum.survey):
        return 'dateSurvey';
      default:
        return 'date';
    }
  }

  _getFromJSON(DocumentSnapshot doc, DataTypeEnum dataType) {
    switch (dataType) {
      case (DataTypeEnum.rate):
        return RateModel.fromJSON(doc.data() as Map<String, dynamic>);
      case (DataTypeEnum.measure):
        return MeasurementModel.fromJSON(doc.data() as Map<String, dynamic>);
      case DataTypeEnum.survey:
        return SurveyModel.fromJSON(doc.data() as Map<String, dynamic>);
      default:
        return ConsultationModel.fromJSON(doc.data() as Map<String, dynamic>);
    }
  }
}
