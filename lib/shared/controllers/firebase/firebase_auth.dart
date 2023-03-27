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
      patient = patient.copyWith(
          uid: firebaseUser.uid,
          email: firebaseUser.email,
          photo: firebaseUser.photoURL);
      PatientController.instance.createPatient(patient);
    } on FirebaseAuthException catch (error) {
      throw FormattedException(
          FirebaseErrors.getTranslatedErrorMessage(error.code));
    }
  }

  Future<PatientModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      final User? firebaseUser = authResult.user;

      //checks if exists an user with this google email
      final patient =
          await PatientController.instance.loadPatient(firebaseUser!);
      if (patient == null) {
        // Google email patients dont have birthdate, it will be necessary update later this attribute
        final newPatient = PatientModel(
          uid: firebaseUser.uid,
          name: firebaseUser.displayName,
          email: firebaseUser.email,
          photo: firebaseUser.photoURL,
        );
        await PatientController.instance.createPatient(newPatient);
        return newPatient;
      } else {
        return patient;
      }
    } on FirebaseAuthException catch (error) {
      throw FormattedException(
          FirebaseErrors.getTranslatedErrorMessage(error.code));
    }
  }

  Future<PatientModel?> loginWithEmailPassword(
      String email, String password) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? firebaseUser = authResult.user;

      if (firebaseUser!.emailVerified) {
        var patient =
            await PatientController.instance.loadPatient(firebaseUser);
        // This 'if' is necessary to update old patients in the database, they dont have email or photo.
        if (patient!.photo == null || patient.email == null) {
          patient = patient.copyWith(
              email: firebaseUser.email, photo: firebaseUser.photoURL);
          PatientController.instance.updatePatient(patient!);
        }
        return patient;
      } else {
        await _auth.signOut();
        return null;
      }
    } on FirebaseAuthException catch (error) {
      throw FormattedException(
          FirebaseErrors.getTranslatedErrorMessage(error.code));
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

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (error) {
      throw FormattedException(
          FirebaseErrors.getTranslatedErrorMessage(error.code));
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } on FirebaseAuthException catch (error) {
      throw FormattedException(
          FirebaseErrors.getTranslatedErrorMessage(error.code));
    }
  }
}
