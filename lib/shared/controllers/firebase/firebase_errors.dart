class FirebaseErrors {
  static String getTranslatedErrorMessage(String errorMessage) {
    switch (errorMessage) {
      case 'weak-password':
        return 'Sua senha é muito fraca.';
      case 'invalid-email':
        return 'Seu e-mail é inválido.';
      case 'email-already-in-use':
      case 'account-exists-with-different-credential':
        return 'E-mail já está sendo utilizado.';
      case 'invalid-credential':
        return 'Seu e-mail é inválido.';
      case 'wrong-password':
        return 'Sua senha está incorreta.';
      case 'user-not-found':
        return 'Não há usuário com este e-mail.';
      case 'user-disabled':
        return 'Este usuário foi desabilitado.';
      case 'too-many-requests':
        return 'Muitas solicitações. Tente novamente mais tarde.';
      case 'operation-not-allowed':
        return 'Operação não permitida.';

      default:
        return 'Um erro indefinido ocorreu.';
    }
  }
}

class FormattedException implements Exception {
  final String message;
  const FormattedException(this.message);

  @override
  String toString() {
    return message;
  }
}
