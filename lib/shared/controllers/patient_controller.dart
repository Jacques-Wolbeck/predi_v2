import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

class PatientController {
  PatientController._init();
  static final PatientController instance = PatientController._init();

  final _patientReference = FirebaseFirestore.instance.collection('pacientes');

  Future<void> createPatient(PatientModel patient) async {
    try {
      final doc = _patientReference.doc(patient.uid);
      await doc.set(patient.toJSON());
    } catch (error) {
      throw Exception("Patient create error: ${error.toString()}");
    }
  }

  Future<void> updatePatient(PatientModel patient) async {
    try {
      final doc = _patientReference.doc(patient.uid);
      await doc.update(patient.toJSON());
    } catch (error) {
      throw Exception("Patient update error: ${error.toString()}");
    }
  }

  Future<void> deletePatient(PatientModel patient) async {
    try {
      final doc = _patientReference.doc(patient.uid);
      await doc.delete();
    } catch (error) {
      throw Exception("Patient delete error: ${error.toString()}");
    }
  }

  //this 'USER' class is from firebase auth
  Future<PatientModel?> loadPatient(User firebaseUser) async {
    final docData = await _patientReference.doc(firebaseUser.uid).get();

    if (docData.exists) {
      return PatientModel.fromJSON(docData.data()!);
    } else {
      return null;
    }
  }
}
