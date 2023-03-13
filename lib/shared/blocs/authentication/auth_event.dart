import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class EmailPasswordSignInRequested extends AuthEvent {
  final String email;
  final String password;

  const EmailPasswordSignInRequested(
      {required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class GoogleSignInRequested extends AuthEvent {}

class CheckLoginRequested extends AuthEvent {}

class SignOutRequested extends AuthEvent {}
