class AuthenticationException implements Exception {
  static const Map<String, String> errors = {
    "EMAIL_EXISTS": "E-mail já cadastrado.",
    "OPERATION_NOT_ALLOWED": "Password sign-in is disabled for this project.",
    "TOO_MANY_ATTEMPTS_TRY_LATER":
        "E-mail bloqueado devido a excesso de tentativas erradas. Tente mais tarde.",
    "EMAIL_NOT_FOUND": "E-mail não encontrado!",
    "INVALID_PASSWORD": "Senha inválida.",
    "USER_DISABLED": "E-mail desativado pelo administrador do sistema.",
  };

  final String key;

  AuthenticationException(this.key);

  @override
  String toString() {
    if (errors.containsKey(key)) {
      return errors[key];
    } else {
      return "Ocorreu um erro na autenticação.";
    }
  }
}
