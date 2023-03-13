import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

import '../patient_controller.dart';

class AuthController {
  AuthController._init();
  static final AuthController instance = AuthController._init();

  final _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  Future<PatientModel?> emailLogin(String email, String password) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? firebaseUser = authResult.user;

      if (firebaseUser!.emailVerified) {
        return await PatientController.instance.loadPatient(firebaseUser);
      } else {
        await _auth.signOut();
        // TODO precisa emitir uma mensagem que o email nao foi ccnfirmado ainda
        return null;
      }
    } on FirebaseAuthException catch (error) {
      throw Exception("Erro no login com email e senha: ${error.message}");
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
      throw Exception('Logout error: ${error.message}');
    }
  }
}
