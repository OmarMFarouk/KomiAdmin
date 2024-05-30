abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class AuthSuccess extends AuthStates {
  String msg = '';
  AuthSuccess(this.msg);
}

class AuthError extends AuthStates {
  String msg = '';
  AuthError(this.msg);
}
