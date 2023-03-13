import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/firebase/firebase_auth.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final authController = AuthController.instance;

  AuthBloc() : super(UnAuthenticated()) {
    //on<GoogleSignInRequested>(_onGoogleSignInResquested);
    on<EmailPasswordSignInRequested>(_onEmailPasswordSignInResquested);
    on<CheckLoginRequested>(_onCheckLoginResquested);
    on<SignOutRequested>(_onSignOutResquested);
  }

  /*void _onGoogleSignInResquested(
      GoogleSignInRequested event, Emitter<AuthState> emit) async {
    emit(Loading());
    try {
      final user = await authController.signInWithGoogle();
      if (user != null) {
        emit(Authenticated(patient: user));
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }*/

  void _onEmailPasswordSignInResquested(
      EmailPasswordSignInRequested event, Emitter<AuthState> emit) async {
    emit(Loading());
    try {
      final patient =
          await authController.emailLogin(event.email, event.password);
      if (patient != null) {
        emit(Authenticated(patient: patient));
      } else {
        emit(UnAuthenticated());
      }
    } catch (error) {
      emit(AuthError(error.toString()));
      emit(UnAuthenticated());
    }
  }

  void _onCheckLoginResquested(
      CheckLoginRequested event, Emitter<AuthState> emit) async {
    emit(Loading());
    try {
      final patient = await authController.checkLogin();
      if (patient != null) {
        emit(Authenticated(patient: patient));
      } else {
        emit(UnAuthenticated());
      }
    } catch (error) {
      emit(AuthError(error.toString()));
      emit(UnAuthenticated());
    }
  }

  void _onSignOutResquested(
      SignOutRequested event, Emitter<AuthState> emit) async {
    emit(Loading());
    await authController.signOut();
    emit(UnAuthenticated());
  }
}
