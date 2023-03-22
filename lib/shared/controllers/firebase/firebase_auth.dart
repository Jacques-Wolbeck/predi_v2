import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:predi_v2/shared/controllers/firebase/firebase_errors.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

import '../patient_controller.dart';

class AuthController {
  AuthController._init();
  static final AuthController instance = AuthController._init();

  final _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  Future<void> registerNewPatient(
      PatientModel patient, String email, String password) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User? firebaseUser = authResult.user;
      firebaseUser!.sendEmailVerification();
      patient.uid = firebaseUser.uid;
      //patient.photo = firebaseUser.photoURL; TODO ADICIONAR FOTO DE USUARIO NO BANCO DE DADOS DO FIREBASE
      PatientController.instance.createPatient(patient);
    } on FirebaseAuthException catch (error) {
      throw Exception(FirebaseErrors.getTranslatedErrorMessage(error.message!));
    }
  }

  Future<PatientModel?> loginWithEmailPassword(
      String email, String password) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? firebaseUser = authResult.user;

      if (firebaseUser!.emailVerified) {
        return await PatientController.instance.loadPatient(firebaseUser);
      } else {
        await _auth.signOut();
        return null;
      }
    } on FirebaseAuthException catch (error) {
      throw Exception(FirebaseErrors.getTranslatedErrorMessage(error.message!));
    }
  }

  Future<PatientModel?> checkLogin() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      return await PatientController.instance.loadPatient(firebaseUser);
    } else {
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } on FirebaseAuthException catch (error) {
      throw Exception(FirebaseErrors.getTranslatedErrorMessage(error.message!));
    }
  }
}
