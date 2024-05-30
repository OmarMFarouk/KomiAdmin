abstract class UserStates {}

class UserInitial extends UserStates {}

class UserSuccess extends UserStates {
  String msg = '';
  UserSuccess(this.msg);
}

class UserError extends UserStates {
  String msg = '';
  UserError(this.msg);
}
